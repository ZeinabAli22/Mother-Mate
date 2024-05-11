// ignore_for_file: prefer_const_constructors

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/pages/Games/game_card.dart';
import 'package:url_launcher/link.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.white, size: 30),
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text(
            'Games',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Row(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 8.0),
              //           child: Container(
              //             height: 50,
              //             width: 50,
              //             decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                   image: NetworkImage(
              //                       'https://i.pinimg.com/564x/c4/60/df/c460df55349b39d267199699b698598a.jpg'),
              //                 ),
              //                 shape: BoxShape.circle),
              //           ),
              //         ),
              //         Text(
              //           'Malak',
              //           style: TextStyle(
              //               fontSize: 25,
              //               color: Colors.indigo,
              //               fontWeight: FontWeight.bold),
              //         )
              //       ],
              //     ),
              //   ],
              // // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Divider(),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Trending',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  children: [
                    Link(
                      uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=es.monkimun.lingokids'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: GameCard(
                          title: 'Lingo kids',
                          imagepath:
                              'https://i.pinimg.com/564x/5a/5e/cc/5a5ecc424c07217cf20cc6ff7bc72136.jpg',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.educational.baby.games'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: GameCard(
                          title: 'Baby Games',
                          imagepath:
                              'https://play-lh.googleusercontent.com/V-xqf8zV5cJduAX4Ul2sHcATaXAf1rKw4rsEFLjgnzT-aTP-YSvqMlLhPxQVDZxHj7I',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.bimiboo.playandlearn'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: GameCard(
                          title: 'Toddler Games',
                          imagepath:
                              'https://i.pinimg.com/564x/08/e7/fb/08e7fb688d2be1bba2f30e22b1b31cd9.jpg',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.outfit7.mytalkingtom2'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: GameCard(
                          title: 'My Talking Tom 2',
                          imagepath:
                              'https://i.pinimg.com/564x/84/77/e0/8477e077633b1cd4e5ea3bd4c7c55160.jpg',
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.amayasoft.dinosaur.games.little.kids.toddlers'),
                      builder: (context, followlink) => InkWell(
                        onTap: followlink,
                        child: GameCard(
                          title: 'Dinosaur games',
                          imagepath:
                              'https://i.pinimg.com/564x/84/89/12/84891263a139ea27761213f467a8986f.jpg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.blueAccent,
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
            ]));
  }
}
