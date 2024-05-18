import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Sign.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String firstName = 'loading...';
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? uid = user?.uid;

    if (uid != null) {
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final Map<String, dynamic> userData =
      userDoc.data() as Map<String, dynamic>;
      setState(() {
        firstName = userData['username'].split(' ')[0]; // Get the first name only
        profileImageUrl = userData['image_url'] ?? 'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
      });
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Signup(),
      ),
    );  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'homescreenboy');
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(profileImageUrl, fit: BoxFit.cover)),
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(firstName,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'update_profile');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.white),
                      )),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              MenuItem(
                title: 'baby details',
                textColor: Colors.black,
                icon: Icons.child_care,
                onpress: () {
                  Navigator.pushNamed(context, 'ListBabiesScreen');

                },
              ),
              SizedBox(
                height: 10,
              ),
              MenuItem(
                title: 'Help',
                textColor: Colors.black,
                icon: Icons.language,
                onpress: () {},
              ),
              SizedBox(
                height: 10,
              ),
              MenuItem(
                title: 'Contact Us',
                textColor: Colors.black,
                icon: Icons.phone_rounded,
                onpress: () {

                },
              ),
              SizedBox(
                height: 10,
              ),
              MenuItem(
                title: 'Logout',
                textColor: Colors.redAccent.shade700,
                icon: Icons.logout_rounded,
                onpress: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final Color? textColor;
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.shade900.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Colors.blue.shade900,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
      ),
      trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )),
    );
  }
}
