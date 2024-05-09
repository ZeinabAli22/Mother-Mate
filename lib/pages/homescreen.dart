// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:proj_app/widget/appcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        // body: ListView(
        //   children: [
        //     Container(
        //       height: size.height * 0.15,
        //       width: size.width,
        //       padding: EdgeInsets.all(20),
        //       margin: EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //           // image: DecorationImage(
        //           //     image: AssetImage('asset/images/motherbaby.png'),
        //           //     fit: BoxFit.cover),
        //           color: Colors.blue[200],
        //           borderRadius: BorderRadius.circular(20)),
        //       child: Stack(
        //         // alignment: Alignment.centerLeft,
        //         children: [
        //           Positioned(
        //             bottom: 0.5,
        //             child: Column(
        //               children: [
        //                 Text(
        //                   'Good Morning',
        //                   style: GoogleFonts.inter(
        //                     fontWeight: FontWeight.bold,
        //                     color: AppColors.whiteColor,
        //                     fontSize: 30,
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 5,
        //                 ),
        //                 Row(
        //                   children: [
        //                     Text(
        //                       'Nada &Mohamed',
        //                       style: GoogleFonts.inter(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 25,
        //                           color: Colors.white),
        //                     ),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Align(
        //             alignment: Alignment.bottomRight,
        //             child: CircleAvatar(
        //               maxRadius: 55,
        //               backgroundImage: NetworkImage(
        //                   'https://i.pinimg.com/564x/15/12/11/1512110aa5ba75d49f9df7911b119bf2.jpg'),
        //             ),
        //           ),
        //           Container(
        //             height: 210,
        //             width: 100,
        //             padding: EdgeInsets.all(8),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 SizedBox(
        //                   height: 5,
        //                 ),
        //                 Text(
        //                   "Baby State",
        //                   style: GoogleFonts.poppins(
        //                       fontWeight: FontWeight.w500,
        //                       color: Colors.black,
        //                       fontSize: 25),
        //                 ),
        //                 SizedBox(
        //                   height: 5,
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                   children: [
        //                     StateCard(
        //                       widget: Column(
        //                         children: [
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Image.asset('asset/images/baby sleep.png'),
        //                               Container(
        //                                 margin:
        //                                     EdgeInsets.only(bottom: 20, right: 8),
        //                                 width: 15,
        //                                 height: 15,
        //                                 decoration: BoxDecoration(
        //                                     color: Colors.orange,
        //                                     shape: BoxShape.circle),
        //                               ),
        //                             ],
        //                           ),
        //                           SizedBox(
        //                             height: 15,
        //                           ),
        //                           Align(
        //                             alignment: Alignment.topLeft,
        //                             child: Text(
        //                               "10 min",
        //                               style: GoogleFonts.poppins(
        //                                   fontWeight: FontWeight.w600,
        //                                   color: Colors.black,
        //                                   fontSize: 20),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 5,
        //                           ),
        //                           Align(
        //                             alignment: Alignment.topLeft,
        //                             child: Text(
        //                               "baby is not ready for this yet",
        //                               style: GoogleFonts.poppins(
        //                                   fontWeight: FontWeight.w400,
        //                                   color: Colors.black,
        //                                   fontSize: 15),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     //Second Baby State
        //                     StateCard(
        //                       widget: Column(
        //                         children: [
        //                           Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               Image.asset('asset/images/baby-bottle.png'),
        //                               Container(
        //                                 margin:
        //                                     EdgeInsets.only(bottom: 20, right: 8),
        //                                 width: 15,
        //                                 height: 15,
        //                                 decoration: BoxDecoration(
        //                                     color: Colors.lightGreen,
        //                                     shape: BoxShape.circle),
        //                               ),
        //                             ],
        //                           ),
        //                           SizedBox(
        //                             height: 15,
        //                           ),
        //                           Align(
        //                             alignment: Alignment.topLeft,
        //                             child: Text(
        //                               "5 min",
        //                               style: GoogleFonts.poppins(
        //                                   fontWeight: FontWeight.w600,
        //                                   color: Colors.black,
        //                                   fontSize: 20),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 5,
        //                           ),
        //                           Align(
        //                             alignment: Alignment.topLeft,
        //                             child: Text(
        //                               "baby is not ready for this yet",
        //                               style: GoogleFonts.poppins(
        //                                   fontWeight: FontWeight.w400,
        //                                   color: Colors.black,
        //                                   fontSize: 15),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}

Widget StateCard({required Widget widget}) {
  return Container(
    padding: EdgeInsets.only(left: 16, top: 16, bottom: 8, right: 8),
    height: 150,
    width: 170,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(1, 3.5),
          )
        ]),
    child: widget,
  );
}
