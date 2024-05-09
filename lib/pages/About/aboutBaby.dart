// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/widget/appcolor.dart';

class AboutBaby extends StatefulWidget {
  const AboutBaby({super.key});

  @override
  State<AboutBaby> createState() => _AboutBabyState();
}

class _AboutBabyState extends State<AboutBaby> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Baby',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: AppColors.whiteColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Box(text: 'Baby\'s Name'),
            SizedBox(height: 25),
            Box(text: 'Date of Birth'),
            SizedBox(height: 25),
            Box(text: 'Baby\'s Weight'),
            SizedBox(height: 50),
            Button(
                text: 'Add Another Child',
                background: AppColors.lightPurple,
                textColor: AppColors.whiteColor),
            SizedBox(height: size.height * 0.25),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'choosegender');
              },
              child: Button(text: 'Continue'),
            )
          ],
        ),
      ),
    );
  }
}

Widget Box({required String text}) {
  return Container(
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: AppColors.grey, blurRadius: 4, offset: Offset(1, 3)),
      ],
    ),
    alignment: Alignment.centerLeft,
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: text,
      ),
      style: TextStyle(
          fontWeight: FontWeight.normal, color: AppColors.grey, fontSize: 15),
    ),
  );
}

Widget Button({required String text, Color? background, Color? textColor}) {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: background ?? AppColors.lightPurple,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(color: textColor ?? AppColors.whiteColor, fontSize: 20),
    ),
  );
}
