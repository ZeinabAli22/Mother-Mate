// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('asset/images/onBoarding3.png'),
        SizedBox(
          height: 20,
        ),
        Text(
          'Monitor Your Baby’s Daily Routine',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          """
    Log information on feeding, soothing, nappy changes and much more. View your data in clear and concise graphs. Baby care covers all bases.
  """,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff737477)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
