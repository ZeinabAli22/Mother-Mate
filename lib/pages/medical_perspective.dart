import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/advertising.dart';

class MedicalPerscription extends StatefulWidget {
  const MedicalPerscription({super.key});

  @override
  State<MedicalPerscription> createState() => _MedicalPerscriptionState();
}
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _MedicalPerscriptionState extends State<MedicalPerscription> {

  late String firstName = 'loading...';
  String profileImageUrl = 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default image URL

  Future<void> getUserData() async {
    if (uid != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      setState(() {
        if (userData.containsKey('username') && userData['username'].isNotEmpty) {
          firstName = userData['username'].split(' ')[0];
        }
        if (userData.containsKey('profileImageUrl') && userData['profileImageUrl'].isNotEmpty) {
          profileImageUrl = userData['profileImageUrl'];
        }
      });

      print('Email: ${userData['email']}');
      print('First name: $firstName');
    } else {
      print('No user is currently signed in.');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hi, $firstName',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.indigo[500],
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
                  child: Row(children: [
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
                              color: Colors.indigo[800],
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
                        color: Colors.indigo,
                      ),
                    ),
                  ]),
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
                  child: Row(children: [
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
                              color: Colors.indigo[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ]),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
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
                  child: Row(children: [
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
                              color: Colors.indigo[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
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
                  ]),
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
