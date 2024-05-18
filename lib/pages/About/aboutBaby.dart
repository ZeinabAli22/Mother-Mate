import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_app/widget/appcolor.dart';

class AboutBaby extends StatefulWidget {
  const AboutBaby({super.key});

  @override
  State<AboutBaby> createState() => _AboutBabyState();
}

class _AboutBabyState extends State<AboutBaby> {
  final _formKey = GlobalKey<FormState>();
  final _babyNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _weightController = TextEditingController();
  final List<Map<String, String>> _babies = [];
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> saveBabyData() async {
    if (_formKey.currentState!.validate()) {
      _addCurrentBabyToList();
      setState(() {
        _isLoading = true;
      });
      try {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'babies': _babies,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Babies\' data saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, 'choosegender');
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

  void _addCurrentBabyToList() {
      setState(() {
        _babies.add({
          'name': _babyNameController.text.trim(),
          'dob': _dobController.text.trim(),
          'weight': _weightController.text.trim(),
        });
        _babyNameController.clear();
        _dobController.clear();
        _weightController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Child information added press continue to confirm'),
            backgroundColor: Colors.green,
          ),
        );
      });

  }

  @override
  void dispose() {
    _babyNameController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 25),
              Box(
                text: 'Baby\'s Name',
                controller: _babyNameController,

              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: Box(
                    text: 'Date of Birth',
                    controller: _dobController,

                  ),
                ),
              ),
              SizedBox(height: 25),
              Box(
                text: 'Baby\'s Weight',
                controller: _weightController,
                keyboardType: TextInputType.number,

              ),
              SizedBox(height: 50),
              Button(
                text: 'Add Another Child',
                background: AppColors.lightPurple,
                textColor: AppColors.whiteColor,
                onTap: _addCurrentBabyToList,
              ),
              SizedBox(height: size.height * 0.25),
              _isLoading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                onTap: saveBabyData,
                child: Button(text: 'Continue'),
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
      style: TextStyle(
          fontWeight: FontWeight.normal, color: AppColors.grey, fontSize: 15),
    ),
  );
}

Widget Button({
  required String text,
  Color? background,
  Color? textColor,
  VoidCallback? onTap,
}) {
  return Container(
    height: 60,
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(8),
    width: double.infinity,
    decoration: BoxDecoration(
      color: background ?? AppColors.lightPurple,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.whiteColor,
          fontSize: 20,
        ),
      ),
    ),
  );
}
