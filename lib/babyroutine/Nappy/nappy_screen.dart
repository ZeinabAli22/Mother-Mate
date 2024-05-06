import 'package:flutter/material.dart';

class Nappy extends StatefulWidget {
  const Nappy({super.key});

  @override
  State<Nappy> createState() => _NappyState();
}

class _NappyState extends State<Nappy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Nappy',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 3,
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                      'asset/images/diaperr.png',
                      color: Colors.grey,
                      scale: 0.5,
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
                    "Add Diaper",
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
