// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:proj_app/widget/custom_text.dart';

class ChooseGender extends StatefulWidget {
  const ChooseGender({Key? key}) : super(key: key);

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
//HomeScreenBoy

  // void openHomeScreen() {
  //   Navigator.of(context).pushNamed('homescreenboy');
  // }

  // void openHomeScreenGirl() {
  //   Navigator.of(context).pushNamed('homescreengirl');
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/image 28.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: 443,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 350,
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: _buildThreeSection(context),
                //   ),
                // ),
                const SizedBox(
                  height: 290,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: _FourSection(context),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget _buildThreeSection(BuildContext context) {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 34),
//     padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 11),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(40),
//       // shape: BoxShape.circle,
//       color: Colors.white,
//     ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           "Child's Name",
//           style: GoogleFonts.poppins(
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(
//           height: 25,
//         ),
//         // const CustomTextFormField(),
//         // const SizedBox(
//         //   height: 15,
//         // ),
//       ],
//     ),
//   );
// }

Widget _FourSection(BuildContext context) {
  // void openHomeScreen() {
  //   Navigator.of(context).pushNamed('homeboy');
  // }

  void openHomeScreenBoy() {
    Navigator.of(context).pushNamed('homescreenboy');
  }

  void openHomeScreenGirl() {
    Navigator.of(context).pushNamed('homescreengirl');
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.white,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Choose Gender",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: openHomeScreenGirl,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Girl",
                          style: GoogleFonts.lemon(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          "asset/images/women-line.svg",
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 35,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: openHomeScreenBoy,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue[200],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Boy",
                          style: GoogleFonts.lemon(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset(
                          "asset/images/men-line.svg",
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// class ChooseGender extends StatefulWidget {
//   const ChooseGender({super.key});

//   @override
//   State<ChooseGender> createState() => _ChooseGenderState();
// }

// class _ChooseGenderState extends State<ChooseGender> {
//   void openHomeScreen() {
//     Navigator.of(context).pushNamed('homescreenboy');
//   }

//   void openHomeScreenGirl() {
//     Navigator.of(context).pushNamed('homescreengirl');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             // Container(
//             //   margin: const EdgeInsets.symmetric(horizontal: 34),
//             //   // padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 11),
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(40),
//             //     // shape: BoxShape.circle,
//             //     color: Colors.white,
//             //   ),
//             //   child: Column(
//             //     children: [
//             //       Text(
//             //         "Choose Gender",
//             //         style: GoogleFonts.poppins(
//             //           fontSize: 25,
//             //           fontWeight: FontWeight.w600,
//             //         ),
//             //       ),
//             //       const SizedBox(
//             //         height: 25,
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: openHomeScreenGirl,
//                 child: Container(
//                   color: Colors.pink[100],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Girl",
//                         style: GoogleFonts.lemon(
//                             fontSize: 45, fontWeight: FontWeight.w500),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       SvgPicture.asset(
//                         "asset/images/women-line.svg",
//                         height: 100,
//                         width: 50,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: openHomeScreen,
//                 child: Container(
//                   color: Colors.blue[200],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Boy",
//                         style: GoogleFonts.lemon(
//                             fontSize: 45, fontWeight: FontWeight.w500),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       SvgPicture.asset(
//                         "asset/images/men-line.svg",
//                         height: 100,
//                         width: 50,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChooseGender extends StatefulWidget {
//   const ChooseGender({super.key});

//   @override
//   State<ChooseGender> createState() => _ChooseGenderState();
// }

// class _ChooseGenderState extends State<ChooseGender> {
//   void openHomeScreen() {
//     Navigator.of(context).pushNamed('homescreenboy');
//   }

//   void openHomeScreenGirl() {
//     Navigator.of(context).pushNamed('homescreengirl');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             // Color.fromARGB(255, 77, 82, 189),
//             // Color.fromARGB(255, 212, 99, 205)
//             Colors.blue.shade300,
//             Colors.pink.shade300,
//           ],
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           // alignment: Alignment.topLeft,
//           children: [
//             SafeArea(
//               child: Column(
//                 // mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 150),
//                     child: Text(
//                       'Choose Gender',
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.bold, fontSize: 30),
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: openHomeScreenGirl,
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               // borderRadius: BorderRadius.circular(20),
//                               shape: BoxShape.circle,
//                               color: Colors.pink[100],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Girl",
//                                   style: GoogleFonts.lemon(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 SvgPicture.asset(
//                                   "asset/images/women-line.svg",
//                                   height: 50,
//                                   width: 50,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: openHomeScreen,
//                           child: Container(
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               // borderRadius: BorderRadius.circular(30),
//                               shape: BoxShape.circle,

//                               color: Colors.blue[200],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Boy",
//                                   style: GoogleFonts.lemon(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 SvgPicture.asset(
//                                   "asset/images/men-line.svg",
//                                   height: 50,
//                                   width: 50,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
