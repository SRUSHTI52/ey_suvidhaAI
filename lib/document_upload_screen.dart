// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'application_form_screen.dart'; // Import the ApplicationFormScreen
//
// class DocumentUploadScreen extends StatefulWidget {
//   @override
//   _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
// }
//
// class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
//   List<String> uploadedFiles = []; // List to store uploaded file names
//
//   Future<void> pickFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       final file = result.files.single;
//       setState(() {
//         uploadedFiles.add(file.name); // Add the selected file to the list
//       });
//       print('Selected file: ${file.name}');
//
//       // Navigate to ApplicationFormScreen after file upload
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ApplicationFormScreen(), // Navigate to the form
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Documents'),
//         backgroundColor: Color(0xFF14267C),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Upload Button
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: pickFile,
//                 icon: Icon(Icons.upload_file, color: Colors.white), // White icon
//                 label: Text(
//                   'Pick a Document',
//                   style: TextStyle(color: Colors.white), // White text
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF14267C),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//
//             // Uploaded Files Section
//             Text(
//               'Uploaded Files:',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 10),
//
//             // Display List of Uploaded Files
//             Expanded(
//               child: uploadedFiles.isEmpty
//                   ? Center(
//                       child: Text(
//                         'No files uploaded yet.',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: uploadedFiles.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           elevation: 2,
//                           margin: const EdgeInsets.only(bottom: 10.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: ListTile(
//                             leading: Icon(Icons.insert_drive_file,
//                                 color: Colors.green),
//                             title: Text(
//                               uploadedFiles[index],
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 setState(() {
//                                   uploadedFiles.removeAt(
//                                       index); // Remove file from the list
//                                 });
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'application_form_screen.dart'; // Import the ApplicationFormScreen

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  List<String> uploadedFiles = []; // List to store uploaded file names

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final files = result.files;
      setState(() {
        uploadedFiles.addAll(files.map((file) => file.name));
      });
      print('Selected files: ${files.map((f) => f.name).join(", ")}');
    }
  }

  void navigateToApplicationForm() {
    if (uploadedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please upload at least one document")),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApplicationFormScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Documents',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF14267C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Button
            Center(
              child: ElevatedButton.icon(
                onPressed: pickFile,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  'Pick Documents',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF14267C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              ),
            ),
            SizedBox(height: 30),

            Text(
              'Uploaded Files:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: uploadedFiles.isEmpty
                  ? Center(
                child: Text(
                  'No files uploaded yet.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              )
                  : ListView.builder(
                itemCount: uploadedFiles.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.insert_drive_file,
                          color: Colors.green),
                      title: Text(
                        uploadedFiles[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            uploadedFiles.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Navigate Button
            Center(
              child: ElevatedButton(
                onPressed: navigateToApplicationForm,
                child: Text(
                  'Check Schemes',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF14267C),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
