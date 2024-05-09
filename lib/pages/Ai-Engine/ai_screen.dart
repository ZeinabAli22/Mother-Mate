import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proj_app/widget/appcolor.dart';

class AiEngineScreen extends StatefulWidget {
  const AiEngineScreen({super.key});

  // Color color;
  // Widget child;

  @override
  State<AiEngineScreen> createState() => _AiEngineScreenState();
}

class _AiEngineScreenState extends State<AiEngineScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color color = AppColors.greenColor.withOpacity(0.4);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFA7AEF9),
      appBar: AppBar(
        // backgroundColor: Colors.purple[800],
        // backgroundColor: AppColors.purpleecolor,
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
                // color: Colors.white,
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
                // color: Colors.white,
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
                      // widget.color.withOpacity(0.5),
                      Color.lerp(color, Colors.black, 0.2)!
                    ])),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.4, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _controller,
                              curve: const _CustomCurve())),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic,
                    // color: Colors.white38,
                    size: 30,
                  )),
            ),
          ],
        ),
      ),
    );
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
