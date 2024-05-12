// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('asset/images/onBoarding2.png'),
        SizedBox(
          height: 20,
        ),
        Text(
          'Help Your Baby Relax',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          """
    With a library of different lullabies and white noises 
    to play to your baby when they are feeling restless.
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
