// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_app/widget/appcolor.dart';

class AboutMother extends StatefulWidget {
  const AboutMother({super.key});

  @override
  State<AboutMother> createState() => _AboutMotherState();
}

class _AboutMotherState extends State<AboutMother> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'mother_name': _nameController.text.trim(),
            'mother_age': _ageController.text.trim(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mother\'s data saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushNamed(context, 'aboutBaby');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save data.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 25),
              Box(
                text: "Name",
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mother\'s name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              Box(
                text: "Age",
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the mother\'s age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.3),
              GestureDetector(
                onTap: _onContinue,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Button(text: 'Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Box({
  required String text,
  required TextEditingController controller,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
}) {
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
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: text,
      ),
      validator: validator,
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
