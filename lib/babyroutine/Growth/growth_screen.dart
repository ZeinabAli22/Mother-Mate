import 'package:flutter/material.dart';

class Growth extends StatefulWidget {
  const Growth({super.key});

  @override
  State<Growth> createState() => _GrowthState();
}

class _GrowthState extends State<Growth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Growth',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 3,
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                      'asset/images/baby.png',
                      color: Colors.grey,
                      scale: 0.7,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No data Show",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff49CCD3))),
                  child: const Text(
                    "Add Weight",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
