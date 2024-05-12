// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proj_app/pages/Onboarding/page1.dart';
import 'package:proj_app/pages/Onboarding/page2.dart';
import 'package:proj_app/pages/Onboarding/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  bool isBack = false;

  List pages = [Page1(), Page2(), Page3()];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.topRight,
            child: TextButton(
                onPressed: () => _controller.jumpToPage(pages.length),
                child: isLastPage
                    ? Text(
                        "",
                      )
                    : Text(
                        'Skip',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xff000000)),
                      )),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  isLastPage = (value == 2);
                  isBack = value < 1;
                });
              },
              children: List.generate(pages.length, (index) => pages[index]),
            ),
          ),
          isLastPage
              ? GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, 'signup'),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff49CCD3),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 75,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 13,
                          dotHeight: 13,
                          activeDotColor: Color(0xff49CCD3),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffDFF7F8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
