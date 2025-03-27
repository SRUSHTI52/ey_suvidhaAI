// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ApplicationFormScreen extends StatefulWidget {
//   @override
//   _ApplicationFormScreenState createState() => _ApplicationFormScreenState();
// }
//
// class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController(text: "John Doe");
//   final TextEditingController _ageController = TextEditingController(text: "18");
//   final TextEditingController _genderController = TextEditingController(text: "Male");
//   final TextEditingController _incomeController = TextEditingController();
//   final TextEditingController _maritalStatusController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();
//   final TextEditingController _casteController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();
//   final TextEditingController _educationController = TextEditingController();
//   final TextEditingController _documentsController = TextEditingController();
//
//   List<dynamic> recommendations = [];
//
//   Future<void> getRecommendations() async {
//     // Show a loading toast
//     Fluttertoast.showToast(
//       msg: "Fetching recommendations...",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.blue,
//       textColor: Colors.white,
//     );
//
//     final url = Uri.parse('http://192.168.0.106:5000/recommend');
//
//    // final url = Uri.parse('http://127.0.0.1:5000/recommend');
//
//     //final url = Uri.parse('http://100.65.109.10:5000/recommend');
//     try {
//       print('Sending request to: $url');
//       final body = json.encode({
//         'age': int.parse(_ageController.text),
//         'gender': _genderController.text,
//         'income': int.parse(_incomeController.text),
//         'marital_status': _maritalStatusController.text,
//         'area_of_residence': _areaController.text,
//         'caste': _casteController.text,
//         'profession': _professionController.text,
//         'education': _educationController.text,
//         'uploaded_documents': _documentsController.text.split(','),
//       });
//
//       print('Request body: $body');
//
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );
//
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         setState(() {
//           recommendations = json.decode(response.body);
//         });
//         Fluttertoast.showToast(
//           msg: "Recommendations fetched successfully!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: "Failed to fetch recommendations. Error: ${response.statusCode}",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       Fluttertoast.showToast(
//         msg: "An error occurred: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Application Form'),
//         backgroundColor: Color(0xFF14267C),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Form Fields
//                 _buildTextField(_nameController, 'Full Name'),
//                 _buildTextField(_ageController, 'Age', TextInputType.number),
//                 _buildTextField(_genderController, 'Gender'),
//                 _buildTextField(_incomeController, 'Income', TextInputType.number),
//                 _buildTextField(_maritalStatusController, 'Marital Status'),
//                 _buildTextField(_areaController, 'Area of Residence'),
//                 _buildTextField(_casteController, 'Caste'),
//                 _buildTextField(_professionController, 'Profession'),
//                 _buildTextField(_educationController, 'Education'),
//                 _buildTextField(_documentsController, 'Uploaded Documents (comma-separated)'),
//                 SizedBox(height: 20),
//
//                 // Get Recommendations Button
//                 ElevatedButton(
//                   onPressed: getRecommendations,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF14267C),
//                   ),
//                   child: Text('Get Recommendations'),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Display Recommendations
//                 ...recommendations.map((rec) => Card(
//                   elevation: 2.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     side: BorderSide(color: Colors.grey.shade200),
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Colors.white, Colors.grey.shade50],
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             rec['scheme_name'],
//                             style: TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1A237E),
//                               letterSpacing: 0.3,
//                             ),
//                           ),
//                           SizedBox(height: 16.0),
//
//                           // Benefits Section (Regular text format)
//                           Container(
//                             padding: EdgeInsets.all(12.0),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.star_outline,
//                                         size: 20.0,
//                                         color: Color(0xFF1A237E)),
//                                     SizedBox(width: 8.0),
//                                     Text(
//                                       'Benefits',
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color(0xFF1A237E),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 Text(
//                                   rec['benefits'],
//                                   style: TextStyle(
//                                     fontSize: 14.0,
//                                     color: Colors.black87,
//                                     height: 1.5,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 16.0),
//
//                           // Required Documents Section (Bullet points)
//                           Container(
//                             padding: EdgeInsets.all(12.0),
//                             decoration: BoxDecoration(
//                               color: Colors.orange.shade50.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.document_scanner_outlined,
//                                         size: 20.0,
//                                         color: Color(0xFFE65100)),
//                                     SizedBox(width: 8.0),
//                                     Text(
//                                       'Required Documents',
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color(0xFFE65100),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 12.0),
//                                 // Display documents as bullet points
//                                 ...(rec['required_documents'] as List<dynamic>).map((doc) => Padding(
//                                   padding: EdgeInsets.only(bottom: 8.0),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(top: 6.0),
//                                         child: Container(
//                                           width: 5.0,
//                                           height: 5.0,
//                                           decoration: BoxDecoration(
//                                             color: Color(0xFFE65100),
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 12.0),
//                                       Expanded(
//                                         child: Text(
//                                           doc,
//                                           style: TextStyle(
//                                             fontSize: 14.0,
//                                             color: Colors.black87,
//                                             height: 1.5,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )).toList(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ))
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, [TextInputType? type]) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//       keyboardType: type,
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationFormScreen extends StatefulWidget {
  @override
  _ApplicationFormScreenState createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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

  Future<void> saveDataToFirebase() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference applications = firestore.collection('applications');

    Map<String, dynamic> formData = {
      'name': _nameController.text.trim(),
      'age': int.tryParse(_ageController.text) ?? 0,
      'gender': _genderController.text.trim(),
      'income': int.tryParse(_incomeController.text) ?? 0,
      'marital_status': _maritalStatusController.text.trim(),
      'area_of_residence': _areaController.text.trim(),
      'caste': _casteController.text.trim(),
      'profession': _professionController.text.trim(),
      'education': _educationController.text.trim(),
      'uploaded_documents': _documentsController.text.isNotEmpty
          ? _documentsController.text.split(',')
          : [],
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await applications.add(formData);
      Fluttertoast.showToast(
        msg: "Application saved successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to save application: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> getRecommendations() async {
    await saveDataToFirebase(); // Save application before fetching recommendations

    Fluttertoast.showToast(
      msg: "Fetching recommendations...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );

    final url = Uri.parse('http://192.168.0.106:5000/recommend');

    try {
      final body = json.encode({
        'age': int.tryParse(_ageController.text) ?? 0,
        'gender': _genderController.text.trim(),
        'income': int.tryParse(_incomeController.text) ?? 0,
        'marital_status': _maritalStatusController.text.trim(),
        'area_of_residence': _areaController.text.trim(),
        'caste': _casteController.text.trim(),
        'profession': _professionController.text.trim(),
        'education': _educationController.text.trim(),
        'uploaded_documents': _documentsController.text.isNotEmpty
            ? _documentsController.text.split(',')
            : [],
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

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
        backgroundColor: Color(0xFF14267C),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, 'Full Name'),
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

                ElevatedButton(
                  onPressed: getRecommendations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14267C),
                  ),
                  child: Text('Submit & Get Recommendations'),
                ),
                SizedBox(height: 20),

                ...recommendations.map((rec) => Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rec['scheme_name'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Benefits: ${rec['benefits']}',
                          style: TextStyle(fontSize: 14.0, color: Colors.black87),
                        ),
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
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }
}

