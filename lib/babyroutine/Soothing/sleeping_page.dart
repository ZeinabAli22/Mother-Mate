import 'package:flutter/material.dart';

class SoothingSleeping extends StatefulWidget {
  const SoothingSleeping({super.key});

  @override
  State<SoothingSleeping> createState() => _SoothingSleepingState();
}

class _SoothingSleepingState extends State<SoothingSleeping> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffDFF7F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Tap to start",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff49CCD3),
                              fontSize: 25),
                        ),
                        Text(
                          "the timer",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff49CCD3),
                              fontSize: 25),
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                              flex: 4,
                              child: Image.asset('asset/images/baby-face.png')),
                          const Expanded(
                              flex: 1,
                              child: Text(
                                "Start",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff49CCD3),
                                    fontSize: 25),
                              )),
                        ],
                      ),
                    ),
                  ],
                ))),
        Expanded(flex: 1, child: Container()),
        const Expanded(
          flex: 1,
          child: SizedBox(),
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
                "Add Manual Entry",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
