// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Jump extends StatefulWidget {
  const Jump({super.key});

  @override
  State<Jump> createState() => _JumpState();
}

class _JumpState extends State<Jump> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacementNamed(context, 'signup'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Expanded(child: _buildMotherMateStack(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotherMateStack(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Image(
            image: AssetImage('asset/images/mother.png'),
            height: 310,
            width: 400,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 30),
          Text(
            // "Mom's Best Assistant",
            'Because every mom deserves a helping hand',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              // color: Color(0xFF122646),
              color: Colors.black,
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     constraints: BoxConstraints(
          //       maxWidth: 510, // Set the desired maximum width
          //       maxHeight: 500,
          //     ),
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         // Image.asset(
          //         //   'asset/images/mother.png',
          //         //   scale: 0.1,
          //         //   alignment: Alignment.center,
          //         // ),
          //         Image(
          //           image: AssetImage('asset/images/mother.png'),
          //           height: 310,
          //           width: 400,
          //           alignment: Alignment.center,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 30),
          // Container(
          //   // width: 220,
          //   // margin: const EdgeInsets.only(right: 39),
          //   child: Text(
          //     "Mom's Best Assistant",
          //     // 'Because every mom deserves a helping hand',
          //     // maxLines: 1,
          //     // overflow: TextOverflow.ellipsis,
          //     // textAlign: TextAlign.center,
          //     style: GoogleFonts.poppins(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w500,
          //       // color: Color(0xFF122646),
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 53),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Navigator.pushNamed(context, 'signup');
          //     },
          //     style: ButtonStyle(
          //       alignment: Alignment.bottomRight,
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //       foregroundColor: const MaterialStatePropertyAll(Colors.black),
          //       padding: MaterialStateProperty.all(
          //           const EdgeInsets.symmetric(horizontal: 55, vertical: 5)),
          //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50))),
          //     ),
          //     child: Text("Get Started",
          //         style: GoogleFonts.poppins(
          //             fontSize: 24, fontWeight: FontWeight.w600)),
          //   ),
          // ),
        ],
      ),
    );
  }
}



// height: 270,
              // width: 297,
// Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Text(
                  //     "Mother Mate",
                  //     style: GoogleFonts.lemonada(
                  //       textStyle: const TextStyle(
                  //         fontSize: 30,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const Image(
                  //   image: AssetImage('asset/images/MotherMate 1.png',

                  //   ),

                  //   height: 270,
                  //   width: 260,
                  //   alignment: Alignment.center,
                  // ),