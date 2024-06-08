
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  bool isScanCompleted = false;

  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('QR Code Scanner Example'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRView(context),
          Positioned(
            bottom: 20.0,
            child: Text(
              isScanCompleted ? 'Scan completed: ${result.code}' : 'Scan a QR code',
              style: TextStyle(
                color: isScanCompleted ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderColor: Colors.green,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (!isScanCompleted) {
        setState(() {
          result = scanData;
          isScanCompleted = true;
        });

        // Perform actions when the scan is completed
        handleScanCompletion(scanData.code!);
      }
    });
  }

  void handleScanCompletion(String qrCodeData) {
    // Display the scanned QR code data
    print('Scan completed: $qrCodeData');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}