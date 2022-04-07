import 'dart:math';
import 'dart:ui' as ui;
import 'package:test_drive/utilities/media_query.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter/material.dart';
import 'package:test_drive/utilities/math.dart';

class Synthscape extends StatefulWidget {
  final Widget child;
  const Synthscape({Key? key, required this.child}) : super(key: key);

  @override
  State<Synthscape> createState() => _SynthscapeState();
}

class _SynthscapeState extends State<Synthscape> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Offset _dragOffset;
  late Offset _pivotOffset;
  late vm.Vector2 _dragVector;
  late double _dragDistance;
  final Duration _duration = const Duration(milliseconds: 250);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: -1.0,
      upperBound: 1.0,
      value: 0.0,
    )..addListener(() {
        setState(() {});
      });
    _dragOffset = Offset.zero;
    _pivotOffset = Offset.zero;
    _dragDistance = 0.0;
    super.initState();
  }

  void center() => _controller.reverse();

  void streach() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onDragStart(context, details),
      onPanUpdate: (details) => _onDragUpdate(context, details),
      onPanEnd: (details) => _onDragEnd(context, details),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E1738),
              Color(0xFF021820),
            ],
          ),
        ),
        child: SizedBox.expand(
          child: AnimatedBuilder(
            animation: _controller,
            child: widget.child,
            builder: (context, child) => CustomPaint(
              painter: _SynthPainter(repaint: _controller, pivot: _pivotOffset),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  void _onDragStart(BuildContext context, DragStartDetails details) {}

  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    _dragOffset += details.delta;
    var dx = _dragOffset.dx / context.screenWidth;
    var dy = _dragOffset.dy / context.screenHeight;
    _pivotOffset = Offset(dx, dy);
    _dragVector = vm.Vector2(dx, dy);
    _dragDistance = _dragVector.distanceTo(vm.Vector2.all(0.0));
    _controller.value = _dragDistance;
    // print('Drag Offset:X($dx), Y($dy); Drag Distance:$_dragDistance');
  }

  void _onDragEnd(BuildContext context, DragEndDetails details) {
    center();
    _dragDistance = 0.0;
    _dragOffset = Offset.zero;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class _SynthPainter extends CustomPainter {
  final int gridSize = 5;
  final double fieldOfView = 256;
  final double viewDistance = 5;
  final double angle = -60;

  final Offset? pivot;
  final Animation<double> repaint;

  _SynthPainter({
    required this.repaint,
    this.pivot = Offset.zero,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    var xOffset = pivot == null ? 0.0 : pivot!.dx;
    var yOffset = pivot == null ? 0.0 : pivot!.dy;

    final sunCenter = Offset(
      size.width / 2,
      size.height * .3,
    );
    final gridBox = Size(size.width / 2, size.height * .65);
    final gridPaint = Paint()
      ..color = Colors.red.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..isAntiAlias = true;

    final glowPaint = Paint()
      ..color = Colors.pinkAccent.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..isAntiAlias = true
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, convertRadiusToSigma(5));

    Paint getSunGlowPaint(Offset from, Offset to) => Paint()
      ..shader = ui.Gradient.linear(
        from,
        to,
        [
          Colors.pink.shade900.withAlpha(64),
          Colors.pink.shade900,
        ],
      )
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(30));

    Paint getSunPaint(Offset from, Offset to) => Paint()
      ..shader = ui.Gradient.linear(
        from,
        to,
        [
          Colors.amber.shade900,
          Colors.yellow.shade300,
        ],
      )
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3));

    // Build Perspective Grid
    var gridPath = Path();
    for (int i = -gridSize; i <= gridSize; i++) {
      // Add vertical lines
      final v1 = rotateX2(
        i,
        -gridSize,
        gridBox.width,
        gridBox.height,
      );
      final v2 = rotateX2(
        i,
        gridSize,
        gridBox.width,
        gridBox.height,
      );
      gridPath.moveTo(v1.dx, v1.dy);
      gridPath.lineTo(v2.dx, v2.dy);

      // Add horizontal lines
      final h1 = rotateX2(
        -gridSize,
        i,
        gridBox.width,
        gridBox.height,
      );
      final h2 = rotateX2(
        gridSize,
        i,
        gridBox.width,
        gridBox.height,
      );
      gridPath.moveTo(h1.dx, h1.dy);
      gridPath.lineTo(h2.dx, h2.dy);
    }

    canvas.save();

    // Draw Sun Glow
    canvas.drawCircle(
        sunCenter,
        120,
        getSunGlowPaint(
            Offset(
              sunCenter.dx,
              sunCenter.dy + 50,
            ),
            Offset(
              sunCenter.dx,
              sunCenter.dy - 50,
            )));
    // Clip Sun Stripes
    for (double i = 0; i <= 6; i++) {
      final c = sunCenter.translate(0, -20 + (i * 20));
      final h = (i + 4).toDouble();
      canvas.clipRect(
        Rect.fromCenter(center: c, width: 250, height: h),
        clipOp: ui.ClipOp.difference,
        doAntiAlias: true,
      );
    }

    // Draw Sun
    canvas.drawCircle(
      sunCenter,
      100,
      getSunPaint(
          Offset(
            sunCenter.dx,
            sunCenter.dy + 50,
          ),
          Offset(
            sunCenter.dx,
            sunCenter.dy - 50,
          )),
    );

    canvas.restore();

    // Draw Perspective Grid
    canvas.drawPath(gridPath, glowPaint);
    canvas.drawPath(gridPath, gridPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => repaint.status != AnimationStatus.dismissed;

  Offset rotateX(
    double x,
    double y,
    double width,
    double height,
  ) {
    double rd, ca, sa, ry, rz, f;

    rd = angle * (pi / 180);
    ca = cos(rd);
    sa = sin(rd);

    ry = y * ca;
    rz = y * sa;

    f = fieldOfView / (viewDistance + rz);
    x = x * f + width;
    y = ry * f + height;

    return Offset(x, y);
  }

  Offset rotateX2(int x, int y, double width, double height) =>
      rotateX(x.toDouble(), y.toDouble(), width, height);
}
