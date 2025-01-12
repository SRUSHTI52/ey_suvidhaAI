# scheme_recommender.py

import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import re

class SchemeRecommender:
    def __init__(self):
        # Assuming the CSV is present in the same directory, or provide the correct path
        self.schemes_df = pd.read_csv('Schemes dataset - Sheet1.csv')
        self.schemes_df = self.schemes_df.replace('null', np.nan)
        self.schemes_df['max_income'] = pd.to_numeric(self.schemes_df['max_income'], errors='coerce')

    def preprocess_documents(self, ocr_text):
        """Preprocesses the OCR text by removing special characters and making it lowercase."""
        cleaned_text = re.sub(r'[^a-zA-Z0-9\s]', '', ocr_text.lower())
        return cleaned_text

    def check_basic_eligibility(self, user_profile, scheme):
        """Checks if the user meets the basic eligibility criteria for a given scheme."""
        score = 1.0

        if pd.notna(scheme['min_age']):
            if user_profile['age'] < scheme['min_age']:
                return 0

        if scheme['gender'] != 'all' and user_profile['gender'] != scheme['gender']:
            return 0

        if pd.notna(scheme['max_income']):
            if user_profile['income'] > scheme['max_income']:
                return 0
            score *= (scheme['max_income'] - user_profile['income']) / scheme['max_income']

        if scheme['marital_status'] != 'all' and user_profile['marital_status'] != scheme['marital_status']:
            return 0

        if scheme['area_of_residence'] != 'all' and user_profile['area_of_residence'] != scheme['area_of_residence']:
            return 0

        if scheme['caste'] != 'all':
            if user_profile['caste'] not in scheme['caste'].split('/'):
                return 0

        if scheme['profession'] != 'all' and user_profile['profession'] != scheme['profession']:
            return 0

        if scheme['education'] != 'all':
            education_levels = {
                'SSC': 1, 'HSC': 2, 'UG': 3, 'PG': 4
            }
            if education_levels.get(user_profile['education'], 0) < education_levels.get(scheme['education'], 0):
                return 0

        return score

    def calculate_benefit_match(self, user_profile, scheme):
        """Calculates the similarity score between user needs and scheme benefits."""
        vectorizer = TfidfVectorizer()
        benefits_text = scheme['all_benefits'].lower()
        needs_text = ' '.join(user_profile['needs']).lower()

        try:
            tfidf_matrix = vectorizer.fit_transform([benefits_text, needs_text])
            similarity = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:2])[0][0]
            return similarity
        except:
            return 0.0

    def get_remaining_documents(self, scheme_name, uploaded_docs):
        """Returns the documents that still need to be uploaded for a given scheme."""
        scheme_docs = self.schemes_df[self.schemes_df['scheme_name'] == scheme_name]['all_docs'].iloc[0]
        required_docs = [doc.strip() for doc in scheme_docs.split(',')]

        uploaded_docs = [doc.lower() for doc in uploaded_docs]
        remaining_docs = [doc for doc in required_docs
                         if not any(uploaded.lower() in doc.lower() or
                                  doc.lower() in uploaded.lower()
                                  for uploaded in uploaded_docs)]

        return remaining_docs

    def generate_needs(self, user_profile):
        """Generates a list of needs based on the user's profile."""
        needs = set()

        # Area-specific needs
        if user_profile['area_of_residence'] == 'rural':
            needs.update(['farming support', 'rural development schemes', 'rural housing support'])
        else:  # urban
            needs.update(['urban housing schemes', 'urban employment support'])

        # Profession-based needs
        profession_needs = {
            'farmer': ['farming support', 'crop insurance', 'agricultural loans', 'equipment subsidies'],
            'student': ['education funding', 'scholarship support', 'skill development', 'education loans'],
            'salaried': ['investment options', 'tax benefits', 'insurance coverage', 'pension schemes'],
            'housewife': ['self employment schemes', 'skill development', 'microfinance support']
        }
        needs.update(profession_needs.get(user_profile['profession'], ['financial assistance']))

        # Income-based needs
        if user_profile['income'] < 250000:
            needs.update(['direct income support', 'social security', 'subsidized services'])
        elif user_profile['income'] < 500000:
            needs.update(['financial assistance', 'subsidy schemes'])

        # Gender and marital status needs
        if user_profile['gender'] == 'female':
            needs.add('women empowerment schemes')
            if user_profile['marital_status'] == 'married':
                needs.add('maternity benefits')
            elif user_profile['marital_status'] == 'widow':
                needs.update(['widow pension', 'widow rehabilitation schemes'])

        # Education-based needs
        education_needs = {
            'SSC': ['higher education support', 'vocational training'],
            'HSC': ['college education support', 'skill development'],
            'UG': ['post graduation support', 'employment schemes'],
            'PG': ['research funding', 'advanced skill development']
        }
        needs.update(education_needs.get(user_profile['education'], []))

        # Caste-based needs
        caste_needs = {
            'sc': ['scheduled caste welfare schemes', 'education scholarships'],
            'st': ['tribal welfare schemes', 'tribal development programs'],
            'obc': ['backward class welfare schemes', 'education support']
        }
        needs.update(caste_needs.get(user_profile['caste'].lower(), []))

        # Differently abled needs
        if user_profile.get('differently_abled') == 'yes':
            needs.update(['disability pension', 'assistive devices support', 'rehabilitation schemes'])

        # Age-based needs
        if user_profile['age'] < 25:
            needs.add('youth development schemes')
        elif user_profile['age'] > 60:
            needs.add('senior citizen schemes')

        return list(needs)

    def get_recommendations(self, user_profile, num_recommendations=5):
        """Generates scheme recommendations based on user profile."""
        recommendations = []

        for _, scheme in self.schemes_df.iterrows():
            eligibility_score = self.check_basic_eligibility(user_profile, scheme)
            if eligibility_score == 0:
                continue

            benefit_score = self.calculate_benefit_match(user_profile, scheme)
            final_score = (eligibility_score * 0.6) + (benefit_score * 0.4)

            if final_score > 0:
                recommendations.append({
                    'scheme_name': scheme['scheme_name'],
                    'score': final_score,
                    'benefits': scheme['all_benefits'],
                    'required_documents': self.get_remaining_documents(
                        scheme['scheme_name'],
                        user_profile.get('uploaded_documents', [])
                    )
                })

        recommendations.sort(key=lambda x: x['score'], reverse=True)
        return recommendations[:num_recommendations]
