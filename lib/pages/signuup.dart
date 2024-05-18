import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/appcolor.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'created_at': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacementNamed('aboutMother');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Failed to sign up.'),
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
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(
                  image: AssetImage("asset/images/SignUp 1.png"),
                  height: 250,
                  width: 411,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      Text("Create your Account", style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            prefixIcon: Icon(Icons.person,color: Colors.grey,),
                            border: InputBorder.none, // This line removes the border
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),

                        ),                                    child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.alternate_email,color: Colors.grey,),
                            border: InputBorder.none, // This line removes the border
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),

                        ),                                    child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                            ),
                            border: InputBorder.none, // This line removes the border
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),

                        ),                                    child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                            suffixIcon: IconButton(
                              icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                            ),
                            border: InputBorder.none, // This line removes the border
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          :  Container(
                        width: 250,
                        // Set the desired width here
                        child:
                             ElevatedButton(
                                                    onPressed: signUp,
                                                    child: Text('Sign Up', style: TextStyle(fontSize: 22,color: Colors.white)),
                                                    style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,

                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                                                    ),
                                                  ),
                          ),
                      SizedBox(height: 20,),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.black54,
                              height: 1,
                              padding: const EdgeInsets.all(10),

                            ),
                          ),SizedBox(width: 4,),
                          Text("Or Sign Up with",style: TextStyle(color: Colors.black54),),SizedBox(width: 4,),
                          Expanded(
                            child: Container(
                              color: Colors.black54,
                              height: 1,
                              padding: const EdgeInsets.all(10),

                            ),
                          ),
                        ],
                      )
                      ,
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              'asset/images/icons8-google.svg',
                              height: 40,// Path to your second SVG image
                              fit: BoxFit.contain, // Adjust as needed
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'asset/images/icons8-facebook.svg',
                              height: 40,// Path to your second SVG image
// Path to your second SVG image
                              fit: BoxFit.contain, // Adjust as needed
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'asset/images/icons8-twitter.svg',
                              height: 40,// Path to your second SVG image
// Path to your second SVG image
                              fit: BoxFit.contain, // Adjust as needed
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('Already have an account?' ,style: TextStyle(color: Colors.black54),),
                         TextButton(
                           onPressed: (){
                             Navigator.of(context).pushNamed('signup');

                           },
                           child: Text('Login' ,style: TextStyle(color: Colors.blue),),
                         ),
                       ],
                     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
