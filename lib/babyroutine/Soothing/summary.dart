import 'package:flutter/material.dart';

class SoothingSummary extends StatefulWidget {
  const SoothingSummary({super.key});

  @override
  State<SoothingSummary> createState() => _SoothingSummaryState();
}

class _SoothingSummaryState extends State<SoothingSummary> {
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
                  "No Data to Show",
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
          child: Container(),
        ),
      ],
    );
  }
}
