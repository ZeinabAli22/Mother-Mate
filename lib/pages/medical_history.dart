import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/Categories_Med.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  void openAllergieScreen() {
    Navigator.pushNamed(context, 'allergies_screen');
  }

  late String username = 'loading...';
  String profileImageUrl = '';

  Future<void> getUserData() async {
    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      setState(() {
        username = userData['username'].split(' ')[0]; // Get the first name only
        profileImageUrl = userData['image_url'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
      });
      print('Email: ${userData['email']}');
      print('Username: ${userData['username']}');
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
              'Hi, $username',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo[500]),
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mother Mate",
                style: GoogleFonts.inter(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('ScheduleScreen');
                },
                child: MedicalCateg(
                  img: 'asset/images/image 46.png',
                  title: 'Schedule',
                ),
              ),
              SizedBox(height: 20),
              // 2nd category
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'doctor_screen');
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'asset/images/image 77.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Doctors',
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
              ),
              SizedBox(height: 20),
              // 3rd category
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'baby_routine');
                },
                child: MedicalCateg(
                  img: 'asset/images/image 35.png',
                  title: 'Baby routine',
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'vaccenation_screen');
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'asset/images/Physical Therapy Icon.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Vaccinations',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 5th category
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'medical_perspective');
                },
                child: MedicalCateg(
                  img: 'asset/images/image 45.png',
                  title: 'Medical History',
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: openAllergieScreen,
                child: Container(
                  height: 90,
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'asset/images/Allergies.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Allergies',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
