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
  late String Username = 'loading...';

  Future<void> getUserData() async {


    if (uid!= null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        Username =userData['username'];

      });
      print(' Email: ${userData['email']}');
      print(' username: ${userData['username']}');
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
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Hi, $Username',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo[500]),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.indigo,
                  size: 30,
                )),
          ],
        ),
        //body
        body: ListView(
          padding: const EdgeInsets.all(14),
          children: const [
            //Upcoming Card
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

            //Health Category
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
            //Nearby Doctor
            NearbyDoctors(),
          ],
        ));
  }
}
