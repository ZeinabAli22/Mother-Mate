import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/appcolor.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.of(context).pushReplacementNamed('homescreenboy');  // Adjust the route as necessary
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Failed to sign in.'),
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(
                  image: AssetImage("asset/images/SignIn.png"),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 25,
                      ),
                      Center(child: Text("Welcome Back", style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold))),
                      SizedBox(height: 8),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),

                        ),                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
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

                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText:!_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline_rounded ,color: Colors.grey,),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisible? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _isPasswordVisible =!_isPasswordVisible),
                            ),
                            border: InputBorder.none, // This line removes the border
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Center(
                            child: Container(
                                                    width: 200, // Set the desired width here
                                                    child: ElevatedButton(
                            onPressed: signIn,
                            child: Text('Sign In', style: TextStyle(fontSize: 20, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[400],
                              minimumSize: Size.fromHeight(50), // Use Size.fromHeight for height only
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                                                    ),
                                                  ),
                          )
                      ,SizedBox(height: 10,)
, Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {},  // Adjust the route as necessary
                          child: Text("Forgot your password?",style: TextStyle(color: Colors.black54),),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.black54,
                              height: 1,
                              padding: const EdgeInsets.all(10),

                            ),
                          ),SizedBox(width: 4,),
                          Text("Or Sign  in with",style: TextStyle(color: Colors.black54),),SizedBox(width: 4,),
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
                              'asset/images/icons8-twitterx.svg',
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
                            Text("Don't have an account?",style: TextStyle(color: Colors.black54),),



                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pushNamed('signuup'),  // Adjust the route as necessary
                              child: Text("Sign up",style: TextStyle(color: Colors.blue),),
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
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
