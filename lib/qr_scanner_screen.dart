// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class QRScannerScreen extends StatefulWidget {
//   @override
//   State<QRScannerScreen> createState() => _QRScannerScreenState();
// }
//
// class _QRScannerScreenState extends State<QRScannerScreen> {
//   bool _isScanning = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//         backgroundColor: Color(0xFF14267C),
//       ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: MobileScannerController(
//               formats: [BarcodeFormat.qrCode],
//               facing: CameraFacing.back,
//             ),
//             onDetect: (capture) {
//               if (!_isScanning) return;
//
//               final List<Barcode> barcodes = capture.barcodes;
//               if (barcodes.isNotEmpty) {
//                 final String? code = barcodes.first.rawValue;
//
//                 if (code != null) {
//                   setState(() {
//                     _isScanning = false;
//                   });
//
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       title: Text('QR Code Found!'),
//                       content: Text(code),
//                       actions: [
//                         if (Uri.tryParse(code)?.hasAbsolutePath ?? false)
//                           TextButton(
//                             onPressed: () async {
//                               final uri = Uri.parse(code);
//                               if (await canLaunchUrl(uri)) {
//                                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//                               } else {
//                                 print("Can't launch URL: $uri");
//                               }
//                             },
//                             child: Text('Open Link'),
//                           ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                           },
//                           child: Text('OK'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               }
//             },
//           ),
//
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               margin: EdgeInsets.all(20),
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 'Align QR code within the box',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Color(0xFF14267C),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              formats: [BarcodeFormat.qrCode],
              facing: CameraFacing.back,
            ),
            onDetect: (capture) {
              if (!_isScanning) return;

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;

                if (code != null) {
                  setState(() {
                    _isScanning = false;
                  });

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('QR Code Found!'),
                      content: Text(code),
                      actions: [
                        if (Uri.tryParse(code)?.isAbsolute ?? false)
                          TextButton(
                            onPressed: () async {
                              final uri = Uri.parse(code);
                              Navigator.pop(context); // Close the dialog first

                              await Future.delayed(Duration(milliseconds: 400)); // Let camera shut down

                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } else {
                                print("Can't launch URL: $uri");
                              }

                              Navigator.pop(context); // Go back to dashboard AFTER opening link
                            },
                            child: Text('Open Link'),
                          ),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Back to dashboard
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),

          // Overlay Text
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Align QR code within the box',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
