import 'package:flutter/material.dart';

class CustomBorder extends Border {
  final List<Paint> borderPaints;

  const CustomBorder({
    required this.borderPaints,
    BorderSide top = BorderSide.none,
    BorderSide left = BorderSide.none,
    BorderSide right = BorderSide.none,
    BorderSide bottom = BorderSide.none,
  })  : assert(borderPaints.length > 0, 'borderPaints must not be empty'),
        super(top: top, left: left, right: right, bottom: bottom);

  factory CustomBorder.all({required List<Paint> borderPaints}) {
    assert(borderPaints.isNotEmpty);
    final color = borderPaints[0].color;
    final strokeWidth = borderPaints[0].strokeWidth;
    final BorderSide side = BorderSide(color: color, width: strokeWidth);
    return CustomBorder.fromBorderSide(side, borderPaints);
  }

  const CustomBorder.fromBorderSide(BorderSide side, this.borderPaints)
      : super.fromBorderSide(side);

  static void _paintUniformBorderWithRadius(
      Canvas canvas, List<Paint> paints, Rect rect, BorderSide side, BorderRadius borderRadius) {
    assert(side.style != BorderStyle.none);
    final RRect outer = borderRadius.toRRect(rect);
    final double width = side.width;
    for (var _paint in paints) {
      if (width == 0.0) {
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.0;
        canvas.drawRRect(outer, _paint);
      } else {
        final RRect inner = outer.deflate(width);
        canvas.drawDRRect(outer, inner, _paint);
      }
    }
  }

  static void _paintUniformBorderWithCircle(
      Canvas canvas, List<Paint> paints, Rect rect, BorderSide side) {
    assert(side.style != BorderStyle.none);
    final double width = side.width;
    final double radius = (rect.shortestSide - width) / 2.0;
    for (var _paint in paints) {
      canvas.drawCircle(rect.center, radius, _paint);
    }
  }

  static void _paintUniformBorderWithRectangle(
      Canvas canvas, List<Paint> paints, Rect rect, BorderSide side) {
    assert(side.style != BorderStyle.none);
    final double width = side.width;
    for (var _paint in paints) {
      canvas.drawRect(rect.deflate(width / 2.0), _paint);
    }
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (isUniform) {
      switch (top.style) {
        case BorderStyle.none:
          return;
        case BorderStyle.solid:
          switch (shape) {
            case BoxShape.circle:
              assert(
                  borderRadius == null, 'A borderRadius can only be given for rectangular boxes.');
              _paintUniformBorderWithCircle(canvas, borderPaints, rect, top);
              break;
            case BoxShape.rectangle:
              if (borderRadius != null) {
                _paintUniformBorderWithRadius(canvas, borderPaints, rect, top, borderRadius);
                return;
              }
              _paintUniformBorderWithRectangle(canvas, borderPaints, rect, top);
              break;
          }
          return;
      }
    }

    super.paint(
      canvas,
      rect,
      textDirection: textDirection,
      shape: shape,
      borderRadius: borderRadius,
    );
  }
}
