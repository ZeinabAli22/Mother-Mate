import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/health_category.dart';
import 'package:proj_app/widget/nearby_doctors.dart';
import 'package:proj_app/widget/upcoming_card.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final String? uid = user?.uid;

class _DoctorScreenState extends State<DoctorScreen> {
  String username = 'loading...';
  String profileImageUrl = '';

  Future<void> getUserData() async {
    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      setState(() {
        username = userData['username'].split(' ')[0]; // Get the first name only
        profileImageUrl = userData['image_url'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default image if not available
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                color: Colors.indigo[500],
              ),
            ),
          ],
        ),

      ),
      // body
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: const [
          // Upcoming Card
          UpcomingCard(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Health Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          // Health Category
          HealthCategories(),
          SizedBox(
            height: 30,
          ),
          Text(
            'Nearby Doctors',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          // Nearby Doctor
          NearbyDoctors(),
        ],
      ),
    );
  }
}
