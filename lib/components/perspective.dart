import 'package:flutter/material.dart';

class Perspective extends StatelessWidget {
  final Widget? child;
  final double? angle;
  const Perspective({Key? key, this.child, this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radians = angle ?? (-3.14 / 2.5);
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(radians)
        ..scale(1.11, .95, 1.0),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
