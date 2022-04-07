import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/utilities/mandelbrot.dart';
import 'package:test_drive/utilities/math.dart';
import 'package:test_drive/utilities/media_query.dart';

class Mandelbrot extends StatefulWidget {
  const Mandelbrot({Key? key}) : super(key: key);

  @override
  State<Mandelbrot> createState() => _MandelbrotState();
}

class _MandelbrotState extends State<Mandelbrot> {
  double reStart = -2.0;
  double reEnd = 1;
  double imStart = -1;
  double imEnd = 1;
  double zoomLevel = 1;
  double zoomFactor = 0.01;
  final maxIterations = 100;
  final _repaint = ChangeNotifier();

  void zoom(BuildContext context, TapUpDetails details) {
    zoomLevel = zoomLevel - zoomFactor;
    var width = context.screenWidth;
    var height = context.screenHeight;
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    var xMin =
        -(((x / width) + .5) * ((reEnd - reStart) / 2)) + (((reEnd - reStart) / 2) + reStart);
    var xMax = (1 - ((x / width) - .5) * ((reEnd - reStart) / 2));
    var yMin = (y / height) * (imEnd - imStart) * imStart;
    var yMax = (1 - (y / height)) * (imEnd - imStart) * imEnd;
    setState(() {
      reStart = xMin;
      reEnd = xMax;
      imStart = yMin;
      imEnd = yMax;
      _repaint.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GestureDetector(
        onTapUp: (details) => zoom(context, details),
        child: CustomPaint(
          painter: MandelbrotPainter(
            repaint: _repaint,
            reStart: reStart,
            reEnd: reEnd,
            imStart: imStart,
            imEnd: imEnd,
            maxIterations: maxIterations,
          ),
        ),
      ),
    );
  }
}

class MandelbrotPainter extends CustomPainter {
  double reStart;
  double reEnd;
  double imStart;
  double imEnd;
  int maxIterations;
  late List<Color> colors;

  MandelbrotPainter({
    Listenable? repaint,
    this.reStart = -2.0,
    this.reEnd = 1,
    this.imStart = -1,
    this.imEnd = 1,
    this.maxIterations = 100,
  }) : super(repaint: repaint) {
    colors = List.generate(maxIterations, (i) {
      double t = i / maxIterations;
      int r = (9 * (1 - t) * t * t * t * 255).toInt();
      int g = (15 * (1 - t) * (1 - t) * t * t * 255).toInt();
      int b = (8.5 * (1 - t) * (1 - t) * (1 - t) * t * 255).toInt();
      return Color.fromARGB(255, r, g, b);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    var sw = Stopwatch()..start();
    for (var x = 0; x < size.width; x++) {
      for (var y = 0; y < size.height; y++) {
        var a = normalize(x, 0, size.width, reStart, reEnd); // real part
        var b = normalize(y, 0, size.height, imStart, imEnd); // imaginary part
        var c = Complex(a, b);
        var m = mandelbrot(c: c, maxIterations: maxIterations);
        var color = m >= maxIterations ? Colors.black : colors[m];
        canvas.drawRect(
          Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
          Paint()..color = color,
        );
      }
    }
    sw.stop();
    print('Mandelbrot Drawn in ${sw.elapsedMilliseconds}ms');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
