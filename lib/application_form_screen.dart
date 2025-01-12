import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class ApplicationFormScreen extends StatefulWidget {
  @override
  _ApplicationFormScreenState createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _casteController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _documentsController = TextEditingController();

  List<dynamic> recommendations = [];

  Future<void> getRecommendations() async {
    // Show a loading toast
    Fluttertoast.showToast(
      msg: "Fetching recommendations...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );

    final url = Uri.parse('http://192.168.0.106:5000/recommend');
    try {
      print('Sending request to: $url');
      final body = json.encode({
        'age': int.parse(_ageController.text),
        'gender': _genderController.text,
        'income': int.parse(_incomeController.text),
        'marital_status': _maritalStatusController.text,
        'area_of_residence': _areaController.text,
        'caste': _casteController.text,
        'profession': _professionController.text,
        'education': _educationController.text,
        'uploaded_documents': _documentsController.text.split(','),
      });

      print('Request body: $body');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          recommendations = json.decode(response.body);
        });
        Fluttertoast.showToast(
          msg: "Recommendations fetched successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to fetch recommendations. Error: ${response.statusCode}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Form'),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Form Fields
                _buildTextField(_ageController, 'Age', TextInputType.number),
                _buildTextField(_genderController, 'Gender'),
                _buildTextField(_incomeController, 'Income', TextInputType.number),
                _buildTextField(_maritalStatusController, 'Marital Status'),
                _buildTextField(_areaController, 'Area of Residence'),
                _buildTextField(_casteController, 'Caste'),
                _buildTextField(_professionController, 'Profession'),
                _buildTextField(_educationController, 'Education'),
                _buildTextField(_documentsController, 'Uploaded Documents (comma-separated)'),
                SizedBox(height: 20),

                // Get Recommendations Button
                ElevatedButton(
                  onPressed: getRecommendations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                  ),
                  child: Text('Get Recommendations'),
                ),
                SizedBox(height: 20),

                // Display Recommendations
                ...recommendations.map((rec) => Card(
                  child: ListTile(
                    title: Text(rec['scheme_name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benefits:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(rec['benefits']),
                        SizedBox(height: 8.0),
                        Text(
                          'Required Documents:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((rec['required_documents'] as List<dynamic>).join(', ')),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, [TextInputType? type]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: type,
    );
  }
}
