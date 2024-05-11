import 'dart:async';
import 'package:flutter/material.dart';

class SoothingSleeping extends StatefulWidget {
  const SoothingSleeping({Key? key}) : super(key: key);

  @override
  State<SoothingSleeping> createState() => _SoothingSleepingState();
}

class _SoothingSleepingState extends State<SoothingSleeping> {
  bool _isTimerRunning = false;
  late Timer _timer;
  int _secondsElapsed = 0;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
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
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 4,
                          child: Image.asset('asset/images/baby-face.png'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            _isTimerRunning ? _formatTime(_secondsElapsed) : "Start",
                            style: TextStyle(
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
        SizedBox( height: 20,)
      ],
    );
  }
}
