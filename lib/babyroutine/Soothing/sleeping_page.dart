import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SoothingSleeping extends StatefulWidget {
  final Function(String) onFinish;

  const SoothingSleeping({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<SoothingSleeping> createState() => _SoothingSleepingState();
}

class _SoothingSleepingState extends State<SoothingSleeping> {
  bool _isTimerRunning = false;
  Timer? _timer;
  int _secondsElapsed = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _isTimerRunning = false;
      _secondsElapsed = 0;
    });
  }

  void _toggleTimer() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
      if (_isTimerRunning) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  String _formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _finishSleep() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      String sleepData = "Slept for ${_secondsElapsed ~/ 3600} hours, ${(_secondsElapsed % 3600) ~/ 60} minutes, and ${_secondsElapsed % 60} seconds";

      await FirebaseFirestore.instance.collection('users').doc(uid).collection('sleepData').add({
        'timestamp': FieldValue.serverTimestamp(),
        'sleepDuration': sleepData,
      });

      widget.onFinish(sleepData);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Sleep Timer Finished"),
          content: Text("Total sleep time: ${_formatTime(_secondsElapsed)}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetTimer();              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: _toggleTimer,
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
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "the timer",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff49CCD3),
                          fontSize: 25,
                        ),
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
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: Image.asset('asset/images/baby-face.png'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            _isTimerRunning ? _formatTime(_secondsElapsed) : "Start",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff49CCD3),
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _resetTimer,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff49CCD3)),
          ),
          child: const Text(
            "Reset Timer",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _finishSleep,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff49CCD3)),
          ),
          child: const Text(
            "Finish",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
