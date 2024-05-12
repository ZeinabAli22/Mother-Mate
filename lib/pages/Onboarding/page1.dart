// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('asset/images/onBoarding1.png'),
        SizedBox(
          height: 20,
        ),
        Text(
          'Track Your Baby’s Growth',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          """
    Interactive graphs showing the most important 
    developments in the baby's weight, height and head 
    circumference during the first year.
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
