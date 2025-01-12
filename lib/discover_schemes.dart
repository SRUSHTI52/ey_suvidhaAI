import 'package:flutter/material.dart';

class DiscoverSchemesScreen extends StatelessWidget {
  final List<Map<String, String>> schemes = [
    {
      'name': 'PM Kisan',
      'description': 'Financial aid for farmers.',
      'eligibility': 'Small and marginal farmers.',
      'benefit': '₹6,000 per year in three installments.'
    },
    {
      'name': 'Ayushman Bharat',
      'description': 'Health insurance for families.',
      'eligibility': 'Low-income families.',
      'benefit': '₹5 lakh annual health coverage.'
    },
    {
      'name': 'Ujjwala Yojana',
      'description': 'Free LPG connections for women.',
      'eligibility': 'BPL households.',
      'benefit': 'Free LPG connection with subsidy.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        final scheme = schemes[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Scheme Description
                Text(
                  scheme['description']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Eligibility
                Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Eligibility: ${scheme['eligibility']!}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Benefits
                Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Benefit: ${scheme['benefit']!}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Action Button
                ElevatedButton(
                  onPressed: () {
                    // Logic for viewing more details or applying
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Learn more about ${scheme['name']}')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Learn More',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
