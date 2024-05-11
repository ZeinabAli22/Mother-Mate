// ignore_for_file: prefer_const_constructors

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/pages/Ai-Engine/ai_screen.dart';
import 'package:proj_app/pages/Games/game.dart';
import 'package:proj_app/pages/Videos/videos.dart';
import 'package:proj_app/pages/storie_screen.dart';

class EntertainmentGirl extends StatefulWidget {
  const EntertainmentGirl({super.key});

  @override
  State<EntertainmentGirl> createState() => _EntertainmentGirlState();
}

class _EntertainmentGirlState extends State<EntertainmentGirl> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.pink[100],
          appBar: AppBar(
            backgroundColor: Colors.pink[100],
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.pink),
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //name of theprofile.
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: GoogleFonts.poppins(
                                color: Colors.blue[900],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Malek',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[900]),
                          )
                        ],
                      ),
                      //profile picture
                      const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: size.height * .45,
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            icon: SvgPicture.asset('asset/images/search.svg'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .85,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          shrinkWrap: true,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoriesScreen())),
                              child: cat(
                                  widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'asset/images/image 8.png',
                                    scale: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Stories',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ],
                              )),
                            ),
                            //Second Category
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GameScreen())),
                              child: cat(
                                  widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'asset/images/image 9.png',
                                    scale: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Games',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ],
                              )),
                            ),
                            //third
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideosScreen())),
                              child: cat(
                                  widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'asset/images/image 10.png',
                                    scale: 2,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Videos',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ],
                              )),
                            ),
                            //FourthCategory

                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AiEngineScreen())),
                              child: cat(
                                  widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('asset/images/image 884.png'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'AI-Engine',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.pinkAccent.shade100,
              animationDuration: const Duration(milliseconds: 300),
              onTap: (index) {
                // print(index);
              },
              buttonBackgroundColor: Colors.white,
              items: const [
                CurvedNavigationBarItem(
                  child: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.play_circle),
                  label: 'Play',
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.person),
                  label: 'Profile',
                ),
              ])),
    );
  }
}

//Widget Cat

Widget cat({required Widget widget}) {
  return Container(
      height: 170,
      width: 175,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.pink),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ]),
      alignment: Alignment.center,
      child: widget);
}