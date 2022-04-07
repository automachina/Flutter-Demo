import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '/models/loyalty.dart';
import '/utilities/paint.dart';
import '/utilities/math.dart';

class LoyaltyGauge extends StatefulWidget {
  final Goal? goal;
  const LoyaltyGauge({Key? key, this.goal}) : super(key: key);

  @override
  _LoyaltyGaugeState createState() => _LoyaltyGaugeState();
}

class _LoyaltyGaugeState extends State<LoyaltyGauge> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _targetPercentage = 0;
  late double _currentPercentage = 0;
  final int _duration = 1500;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _duration),
      debugLabel: 'loyalty gauge animation',
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant LoyaltyGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal?.id == widget.goal?.id) return;
    _controller.stop();
    var goal = widget.goal;
    var oldGoal = oldWidget.goal;
    if (goal != null) {
      setState(() {
        if (goal.completed) {
          _targetPercentage = 1;
          _currentPercentage = oldGoal?.completed != true ? 0 : 1;
        } else {
          _currentPercentage = oldGoal != null ? (oldGoal.progress / oldGoal.target) : 0;
          _targetPercentage = goal.progress / goal.target;
          var durr = (_duration * (_currentPercentage - _targetPercentage).abs()).round();
          if (durr <= 0) durr = _duration;
          _controller.duration = Duration(milliseconds: durr);
        }
        _controller.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var target = _targetPercentage > 0 ? _targetPercentage : 0;
    var gaugeValue = ((_controller.value * 100) * target).toStringAsFixed(0);
    return GestureDetector(
      onTap: () => _controller.isAnimating ? _controller.stop() : _controller.reset(),
      child: CustomPaint(
        painter: _LoyaltyPainter(
            animation: _animation,
            targetPercentage: _targetPercentage,
            currentPercentage: _currentPercentage),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Text(
              '$gaugeValue%',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _LoyaltyPainter extends CustomPainter {
  static const double _startAngle = 135;
  static const double _endAngle = 270;
  final Animation<double> animation;
  final double targetPercentage;
  final double? currentPercentage;
  _LoyaltyPainter({
    Listenable? repaint,
    required this.animation,
    required this.targetPercentage,
    this.currentPercentage,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    final scalePaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    var center = Offset(size.width / 2, size.height / 2);

    final scale = Path()
      ..addArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        angleToRadians(_startAngle),
        angleToRadians(_endAngle),
      );

    var startingAngle = currentPercentage == null ? _startAngle : 270 * currentPercentage!;
    var endingAngle = 270 * targetPercentage;
    var angle = startingAngle + (endingAngle - startingAngle) * animation.value;

    final progress = Path()
      ..addArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        angleToRadians(_startAngle),
        angleToRadians(angle),
      );

    canvas.drawPath(
      scale.shift(const Offset(2, 2)),
      scalePaint.copyWith(
        color: Colors.tealAccent,
      ),
    );
    canvas.drawPath(scale, scalePaint);
    canvas.drawPath(progress, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      animation.status != AnimationStatus.completed;
}
