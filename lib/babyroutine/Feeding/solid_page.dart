import 'package:flutter/material.dart';

class FeedingSolid extends StatefulWidget {
  const FeedingSolid({super.key});

  @override
  State<FeedingSolid> createState() => _FeedingSolidState();
}

class _FeedingSolidState extends State<FeedingSolid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 4,
          child: SizedBox(
            child: Column(
              children: [
                Image.asset('asset/images/meal.png'),
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
