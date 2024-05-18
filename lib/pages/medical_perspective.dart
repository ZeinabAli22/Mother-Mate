import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/advertising.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MedicalPerscription extends StatefulWidget {
  const MedicalPerscription({super.key});

  @override
  State<MedicalPerscription> createState() => _MedicalPerscriptionState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _MedicalPerscriptionState extends State<MedicalPerscription> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  String firstName = 'loading...';
  String profileImageUrl = 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default image URL
  String gender = 'unknown';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          profileImageUrl = userData['profileImageUrl'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default image if null
          firstName = userData['username'] ?? 'loading...'; // Default name if null
          gender = userData['gender'] ?? 'unknown'; // Default gender if null
        });
      } else {
        print('No data found for the user.');
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  void _scanQRCode() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildQrView(context),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.flip_camera_android),
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
      Navigator.pop(context); // Close the modal sheet
      // Process the scanned data
      print('Scanned QR code: ${result?.code}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = gender == 'Boy' ? Colors.blue[300]! : Colors.pink[300]!;
    final Color textColor = gender == 'Boy' ? Colors.indigo[500]! : Colors.pink[500]!;
    final Color buttonColor = gender == 'Boy' ? Colors.indigo[800]! : Colors.pink[800]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(width: 10),
            Text(
              'Hi, $firstName',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "Mother Mate",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'View Prescription',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.open_in_new_rounded,
                          color: buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
              ),
              const SizedBox(height: 30),
              AdsDoctor(),
              const SizedBox(height: 30),
              InkWell(
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scan Prescription',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: IconButton(
                          onPressed: _scanQRCode,
                          icon: Icon(
                            Icons.qr_code_scanner_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: _scanQRCode,
              ),
              SizedBox(height: 30),
              InkWell(
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload Photo',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.upload_file_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
