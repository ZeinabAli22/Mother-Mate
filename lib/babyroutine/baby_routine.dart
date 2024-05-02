import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/babyroutine/Feeding/feeding_screen.dart';
import 'package:proj_app/babyroutine/growth_screen.dart';
import 'package:proj_app/babyroutine/nappy_screen.dart';
import 'package:proj_app/babyroutine/soothing_screen.dart';

class BabyRoutineScreen extends StatefulWidget {
  const BabyRoutineScreen({super.key});

  @override
  State<BabyRoutineScreen> createState() => _BabyRoutineScreenState();
}

class _BabyRoutineScreenState extends State<BabyRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        title: const Text(
          'Baby Routine',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      //Body
      // body: ListView(
      //   children: <Widget>[
      //     const Padding(
      //       padding: EdgeInsets.only(top: 15.0, left: 10.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           // IconButton(
      //           //   onPressed: () {
      //           //     Navigator.pushNamed(context, 'medical_history');
      //           //   },
      //           //   icon: const Icon(
      //           //     Icons.arrow_back,
      //           //     color: Colors.white,
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 25.0,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 40.0),
      //       child: Row(
      //         children: <Widget>[
      //           Text(
      //             'Baby',
      //             style: GoogleFonts.inter(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 35.0),
      //           ),
      //           const SizedBox(
      //             width: 10.0,
      //           ),
      //           Text(
      //             'Routine',
      //             style: GoogleFonts.inter(color: Colors.white, fontSize: 35.0),
      //           ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 40.0,
      //     ),
      //     Container(
      //       height: MediaQuery.of(context).size.height - 185.0,
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(75.0),
      //           topRight: Radius.circular(75),
      //         ),
      //       ),
      //       child: ListView(
      //         primary: false,
      //         padding: const EdgeInsets.only(left: 25.0, right: 20.0),
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.only(top: 45.0),
      //             child: SizedBox(
      //               height: MediaQuery.of(context).size.height - 300.0,
      //               child: ListView(
      //                 children: [
      //                   //Card for the routine
      //                   _buildRoutineCard('asset/images/nap.png', 'Naps',
      //                       'Total:', 'Time:', 'Awake:', '2', '1h30m', '3h10m'),
      //                   const SizedBox(height: 15),
      //                   _buildRoutineCard('asset/images/Food.png', 'Food',
      //                       'Bottles:', 'Meals:', 'Last:', '180ml', '0', '40m'),
      //                   const SizedBox(
      //                     height: 15,
      //                   ),
      //                   _buildRoutineCard('asset/images/Nappe.png', 'Nappies',
      //                       'Wet:', 'Dirty:', 'Last:', '3', '2', '40m'),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.blue,
      //   child: const Icon(
      //     Icons.add,
      //     size: 35,
      //   ),
      // ),

      //body:

      body: Stack(
        children: [
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //header
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
                  //search barrr
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                            color: Colors.blue[800]),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeedingMain(),
                              )),
                          child: cat(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/images/bot.png',
                                scale: 0.8,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Feeding",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                              )
                            ],
                          ))),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SoothingMain(),
                              )),
                          child: cat(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/images/soothing.png',
                                scale: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Soothing",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                              )
                            ],
                          ))),
                    ],
                  ),
                  GridView.count(
                    // crossAxisCount is the number of columns
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nappy(),
                              )),
                          child: cat(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/images/Nappe.png',
                                scale: 0.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Nappy",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                              )
                            ],
                          ))),
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Growth(),
                              )),
                          child: cat(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/images/Growth.png',
                                scale: 1,
                                // color: AppColors.primary,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Growth",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 25),
                              )
                            ],
                          ))),
                    ],
                  ),

                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
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
          ]),
    );
  }

  //Class for the list of the routine
  Widget _buildRoutineCard(String imagePath, String cardTitle, String info,
      String info2, String info3, String unit, String unit2, String unit3) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 13.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(imagePath),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            cardTitle,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                info,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 130,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        info2,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      info3,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 200,
                          margin: const EdgeInsets.only(left: 3, right: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  unit,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Spacer(
                                flex: 52,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  unit2,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Spacer(
                                flex: 47,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  unit3,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}

//widgett cat
Widget cat({required Widget widget}) {
  return Container(
      height: 170,
      width: 175,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ]),
      alignment: Alignment.center,
      child: widget);
}
