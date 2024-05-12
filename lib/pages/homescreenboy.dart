// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Sign.dart';

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

  late String username = 'loading...';

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
        username = userData['username'];
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
      // Change this color to the desired one
      statusBarIconBrightness:
          Brightness.dark, // Change the status bar icons' color (dark or light)
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mother Mate",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            // color: Colors.black
                          )),
                      // const SizedBox(
                      //   width: ,
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'profile_screen');
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Welcome back ",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "$username ! ",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                      Spacer(), // Add Spacer to push the button to the right
                      ElevatedButton(
                        onPressed: () {
                          // Implement logout logic here
                          // For example, navigate to the signup screen
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Signup(), // Replace Signup with your actual signup screen
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red), // Set the background color to red
                        ),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        const CategoryCard(
                          title: "MotherHood \n Community",
                          svgSrc: 'asset/images/Medical Doctor.png',
                        ),

                        //2nd
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            // color: Colors.white,
                            // color: Color(0xFF002950),
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
                                  // Spacer(),
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
                                      // color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //3rd Feature Entertainment
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 4, 105, 11),
                            // color: Colors.white,
                            // color: Color(0xFF002950),
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
                                  const Image(
                                    image: AssetImage(
                                        "asset/images/Rectangle 27.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  // Spacer(),
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
                                      // color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///4th Feature Instruction
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[900],
                            // color: Colors.white,
                            // color: Color(0xFF002950),
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
                                  // Spacer(),

                                  Text(
                                    "Mother\nInstructions",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      // color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //    const SizedBox(
                    //   height: 20,
                    // ),
                    // Text("Nearaby Doctors:")
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
                      autoPlay: true, // Enable auto play
                      autoPlayInterval:
                          Duration(seconds: 3), // Set auto play interval
                      height: 125,
                      enlargeCenterPage: false,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                    ),
                    items: [
                      // Add multiple instances of your Container with different data
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
                      ), // Add more instances of your container as needed
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
  // void openCommunityScreen() {
  //   // Navigator.pushNamed(context as BuildContext, '/home_layout');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 182, 76, 76),
        // color: Colors.white,
        // color: Color(0xFF002950),
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
              // Spacer(),
              const SizedBox(
                height: 15,
              ),
              Image(
                image: AssetImage(svgSrc),
                height: 90,
                width: 90,
              ),
              // Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  // color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
