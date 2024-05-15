import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/appcolor.dart';

class AiEngineScreen extends StatefulWidget {
  const AiEngineScreen({Key? key}) : super(key: key);

  @override
  State<AiEngineScreen> createState() => _AiEngineScreenState();
}

final Random _random = Random();

int randomPercentage(int min, int max) {
  return min + _random.nextInt(max - min + 1);
}

class _AiEngineScreenState extends State<AiEngineScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color color = AppColors.greenColor.withOpacity(0.4);

  final List<Map<String, dynamic>> crySituations = [
    {'situation': 'Hungry', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Tired', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Needs a diaper change', 'percentage': randomPercentage(20, 60)},
    {'situation': 'In pain', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Bored', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Lonely', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Too hot', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Too cold', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Overstimulated', 'percentage': randomPercentage(20, 60)},
    {'situation': 'Understimulated', 'percentage': randomPercentage(20, 60)},
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < crySituations.length; i++) {
      crySituations[i]['percentage'] = randomPercentage(20, 60);
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        elevation: 0.0,
        title: Text(
          'AI Engine',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Radar',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Identify your child\'s crying',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomPaint(
              painter: _CustomPaint(_controller, color),
              child: SizedBox(
                height: 300,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        color,
                        Color.lerp(color, Colors.black, 0.2)!
                      ]),
                    ),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.4, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: const _CustomCurve(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _analyzeCry,
              child: Icon(Icons.mic, color: Colors.black54,),
            ),
          ],
        ),
      ),
    );
  }

  void _analyzeCry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Listening...',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();

      crySituations.shuffle();

      // Generate random percentages that sum to 100
      final int percentage1 = randomPercentage(20, 60);
      final int percentage2 = 100 - percentage1;

      List<Map<String, dynamic>> results = [
        {'situation': crySituations[0]['situation'], 'percentage': percentage1},
        {'situation': crySituations[1]['situation'], 'percentage': percentage2},
      ];

      // Sort results to have the highest percentage at the top
      results.sort((a, b) => b['percentage'].compareTo(a['percentage']));

      List<Widget> situationWidgets = results.map((result) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              result['situation'],
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              '${result['percentage']}%',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        );
      }).toList();

      // Show notification
      final highestResult = results[0];
      final String notificationMessage = 'The baby may be ${highestResult['situation']} with a percentage of ${highestResult['percentage']}%.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(notificationMessage),
          duration: Duration(seconds: 3),
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Analysis Result',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: situationWidgets,
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _CustomCurve extends Curve {
  const _CustomCurve();
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    } else {
      return sin(t * pi);
    }
  }
}

class _CustomPaint extends CustomPainter {
  _CustomPaint(this._animation, this.color) : super(repaint: _animation);
  Color color;
  Animation<double> _animation;
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 5; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 6.0)).clamp(0.0, 1.0);
    final _color = color.withOpacity(opacity);
    final size = rect.width / 2;
    final area = size * size;
    final radius = sqrt(area * value / 6);
    final paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }
}
