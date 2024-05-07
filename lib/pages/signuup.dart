import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final Name = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Future signUp() async {
  //   if (passwordConfirmed()) {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim());
  //     Navigator.of(context).pushNamed('/');
  //   }
  // }



  Future<void> signUp() async {
    print('start');
    if (passwordConfirmed()) {

      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'username': Name.text.trim(),
      'email':  _emailController.text.trim(),
    });
    Navigator.of(context).pushNamed('/');
      print('done');

  }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //signup

  void openSigninScreen() {
    Navigator.of(context).pushNamed('signup');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("asset/images/SignUp 1.png"),
                      height: 250,
                      width: 411,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Create your Account",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // CutomerFormTextField(),
                        // const CustomName(),
                        // const SizedBox(height: 20),
                        //Email Textfield
                        // const CustomEmail(),
                        Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Center(
                              child: TextFormField(
                                //controller
                                controller: Name,
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "User Name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //end of Email Textfield
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Center(
                              child: TextFormField(
                                //controller
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email Address",
                                  prefixIcon: Icon(
                                    Icons.alternate_email_rounded,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //end of Email Textfield
                        const SizedBox(
                          height: 20,
                        ),
                        //Password Textfield
                        Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Center(
                              child: TextFormField(
                                //controller
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                onFieldSubmitted: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black26,
                                  ),
                                  suffixIcon:
                                      Icon(Icons.remove_red_eye_rounded),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //end of Password TextField
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 42,
                          width: 340,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Center(
                              child: TextFormField(
                                //controller
                                controller: _confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                onFieldSubmitted: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black26,
                                  ),
                                  suffixIcon:
                                      Icon(Icons.remove_red_eye_rounded),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //end of Confirm Password TextField
                        const SizedBox(
                          height: 20,
                        ),
                        //Sign Up Button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 60),
                          child: Container(
                            height: 53,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: GestureDetector(
                                // onTap: () {
                                //   Navigator.pushNamed(context, "/choosegender");
                                // },
                                onTap: signUp,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //end of SignUp Button
                        const SizedBox(height: 20),
                        ////////
                        const SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.8,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "  Or Sign Up With ",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.8,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 14,
                            ),
                            /////Google
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  "asset/images/icons8-google.svg",
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            /////Facebook
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  "asset/images/icons8-facebook.svg",
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),

                            ///Twitter
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  "asset/images/icons8-twitter.svg",
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ? ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: openSigninScreen,
                              child: Text(
                                " Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
