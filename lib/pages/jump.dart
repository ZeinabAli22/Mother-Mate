// ignore_for_file: prefer_const_constructors

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
        (value) => Navigator.pushReplacementNamed(context, 'onboarding_page'));
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
            image: DecorationImage(
              image: AssetImage('asset/images/image start.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: 443,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Expanded(
                    child: SingleChildScrollView(
                  child: _buildMotherMateStack(context),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotherMateStack(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 352),
      padding: const EdgeInsets.symmetric(horizontal: 63),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 236,
              width: 297,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Mother Mate",
                      style: GoogleFonts.lemonada(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Image(
                    image: AssetImage('asset/images/image 24.png'),
                    height: 184,
                    width: 260,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 46),
          Container(
            width: 220,
            margin: const EdgeInsets.only(right: 39),
            child: Text(
              "Mom's \nBest Assistance",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.lemon(
                // TextStyle(
                //   fontSize: 20,
                //   fontWeight: FontWeight.w200,
                // ),
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ),
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
