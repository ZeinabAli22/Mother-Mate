// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  late String username = 'loading...';
  late String gender = 'unknown';
  late String profilePicUrl = '';

  Future<void> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;

      setState(() {
        username = userData['username'];
        gender = userData['gender'] ?? 'unknown';
        profilePicUrl = userData['profilePicUrl'] ??
            'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'; // Default profile picture
      });
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
    var size = MediaQuery.of(context).size;
    Color backgroundColor = gender == 'Boy'
        ? Colors.blue[300]!
        : gender == 'Girl'
        ? Colors.pink[300]!
        : Colors.grey[300]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Row(children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(profilePicUrl),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Hello, $username',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_rounded,
                color: Colors.indigo,
                size: 30,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Text("Mother Mate",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 15,
              ),
              AllergyCard(),
            ]),
          ),
        ],
      ),
    );
  }
}

class AllergyCard extends StatelessWidget {
  const AllergyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '  Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Add Your Allergies Here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            Image.asset(
              'asset/images/Allergie.png',
              height: 180,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'allergy');
      },
    );
  }
}
