from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import re
from scheme_recommender import SchemeRecommender

# Include your existing SchemeRecommender class here

app = Flask(__name__)
from flask_cors import CORS
app = Flask(__name__)
CORS(app)


@app.route('/')
def home():
    return "Welcome to the Recommendation API! Use the '/recommend' endpoint with POST."


@app.route('/recommend', methods=['POST'])
def recommend_schemes():
    data = request.json
    recommender = SchemeRecommender()
    user_profile = data
    user_profile['needs'] = recommender.generate_needs(user_profile)
    recommendations = recommender.get_recommendations(user_profile)

    return jsonify(recommendations)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
