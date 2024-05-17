// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:proj_app/pages/Videos/videos.dart';

// import 'Sign.dart';

class HomeScreenB extends StatefulWidget {
  const HomeScreenB({Key? key}) : super(key: key);
  @override
  State<HomeScreenB> createState() => _HomeScreenBState();
}

class _HomeScreenBState extends State<HomeScreenB> {
  void openMedicalScreen() {
    Navigator.pushNamed(context, 'medical_history');
  }

  void openEntertainScreen() {
    Navigator.pushNamed(context, 'entertainment');
  }

  void openInstructionScreen() {
    Navigator.pushNamed(context, 'Instruction');
  }

  late String firstName = 'loading...';
  String profileImageUrl = '';

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
        firstName =
            userData['username'].split(' ')[0]; // Get the first name only
        profileImageUrl = userData['image_url'] ??
            'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg';
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
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[300],
      statusBarIconBrightness: Brightness.dark,
    ));

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue[200],
        backgroundColor: Color(0XFFA3D5FF),
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(color: Color(0XFFA3D5FF)),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Text("Mother Mate",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hello,  ",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "$firstName ! ",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          // color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'profile_screen');
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(profileImageUrl),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Appointments:',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Cards(
                        title: 'Dr.Laila',
                        subtitle: '09:30 AM',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Services:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => Signup(),
                      //       ),
                      //     );
                      //   },
                      //   style: ButtonStyle(
                      //     backgroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.red),
                      //   ),
                      //   child: Text(
                      //     'Logout',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      // childAspectRatio: 1.0,
                      crossAxisSpacing: 55,
                      mainAxisSpacing: 35,
                      children: <Widget>[
                        const CategoryCard(
                          title: "MotherHood \n Community",
                          svgSrc: 'asset/images/Medical.png',
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF3D6196),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 13),
                                blurRadius: 17,
                                spreadRadius: -23,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: openMedicalScreen,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Image(
                                    image: AssetImage("asset/images/Pill.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Medical History",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0XFF2F6C4F),
                            // color: Color(0XFFC97777),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 13),
                                blurRadius: 17,
                                spreadRadius: -23,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: openEntertainScreen,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Image.asset(
                                    'asset/images/Rectangle.png',
                                    scale: 0.8,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Entertainment",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[900],
                            // color: Color(0XF000000),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 13),
                                blurRadius: 17,
                                spreadRadius: -23,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: openInstructionScreen,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Image(
                                    image:
                                        AssetImage("asset/images/Instruct.png"),
                                    height: 80,
                                    width: 80,
                                  ),
                                  Text(
                                    "Mother\nInstructions",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Nearby Doctors:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      height: 125,
                      enlargeCenterPage: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                    ),
                    items: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 125,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            children: [
                              const Image(
                                  image: AssetImage('asset/images/Image.png')),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr.Mazen",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "About 800m Away from your Location",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;

  const CategoryCard({
    super.key,
    required this.svgSrc,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFC97777),
        // color: Color(0XFFFFEBAE),
        // color: Color(0XFF557478),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 13),
            blurRadius: 17,
            spreadRadius: -23,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'home_layout');
          },
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                svgSrc,
                scale: 0.8,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String subtitle;

  const Cards({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Color(0XFF213052),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFF2EBFDF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  '9 MAY',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  // fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w300,
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
