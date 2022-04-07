import 'package:flutter/material.dart';

extension PaintExtensions on Paint {
  Paint copyWith({
    Color? color,
    BlendMode? blendMode,
    ColorFilter? colorFilter,
    PaintingStyle? style,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    double? strokeWidth,
    MaskFilter? maskFilter,
    bool? isAntiAlias,
  }) {
    return Paint()
      ..color = color ?? this.color
      ..blendMode = blendMode ?? this.blendMode
      ..colorFilter = colorFilter ?? this.colorFilter
      ..style = style ?? this.style
      ..strokeCap = strokeCap ?? this.strokeCap
      ..strokeJoin = strokeJoin ?? this.strokeJoin
      ..strokeWidth = strokeWidth ?? this.strokeWidth
      ..maskFilter = maskFilter ?? this.maskFilter
      ..isAntiAlias = this.isAntiAlias;
  }
}
