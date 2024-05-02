import 'package:flutter/material.dart';

class FeedingBottle extends StatefulWidget {
  const FeedingBottle({super.key});

  @override
  State<FeedingBottle> createState() => _FeedingBottleState();
}

class _FeedingBottleState extends State<FeedingBottle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: Container()),
        Expanded(
          flex: 3,
          child: SizedBox(
            child: Column(
              children: [
                Transform.rotate(
                    angle: 30.7,
                    child: Image.asset(
                      'asset/images/baby-bottle.png',
                      color: Colors.grey,
                      scale: 0.5,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "No Feed to Show",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
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
                "Add Feed",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
