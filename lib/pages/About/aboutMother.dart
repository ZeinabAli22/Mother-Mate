// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/widget/appcolor.dart';

class AboutMother extends StatefulWidget {
  const AboutMother({super.key});

  @override
  State<AboutMother> createState() => _AboutMotherState();
}

class _AboutMotherState extends State<AboutMother> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Mother',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            SizedBox(height: 25),
            Box(text: "Name"),
            SizedBox(
              height: 25,
            ),
            Box(text: "Age"),
            SizedBox(height: size.height * 0.3),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'aboutBaby');
                },
                child: Button(text: 'Continue'))
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
