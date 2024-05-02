import 'package:flutter/material.dart';

class FeedingSummary extends StatefulWidget {
  const FeedingSummary({super.key});

  @override
  State<FeedingSummary> createState() => _FeedingSummaryState();
}

class _FeedingSummaryState extends State<FeedingSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(flex: 1, child: Container()),
        const Expanded(
          flex: 3,
          child: SizedBox(
            child: Column(
              children: [
                Icon(
                  Icons.dataset_rounded,
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "No Feed to Show",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
