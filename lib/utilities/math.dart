import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

double angleToRadians(double angle) => angle * (pi / 180);

double convertRadiusToSigma(double radius) => radius * 0.57735 + 0.5;

/// Returns a value normalized from in input range to the output range.
/// If the value is 50 and the input range is [0, 100] and the output range is [0, 1]
/// then the result will be 0.5.
double normalize(
  num value,
  double minInput,
  double maxInput,
  double minOutput,
  double maxOutput,
) =>
    (value - minInput) * (maxOutput - minOutput) / (maxInput - minInput) + minOutput;

Matrix4 orthographic({
  double fovy = (45 * pi) / 180,
  double aspect = 1,
  double focalDistance = 1,
  double near = 0.1,
  double far = 500,
}) {
  assert(fovy <= pi * 2, 'fovy must be provided in radians');
  final double halfY = fovy / 2;
  final double top = focalDistance * tan(halfY);
  final double right = top * aspect;

  return makeOrthographicMatrix(
    -right,
    right,
    -top,
    top,
    near,
    far,
  );
}

Matrix4 perspective(
    {double? fovy,
    double fov = (45 * pi) / 180,
    double aspect = 1,
    double near = 0.1,
    double far = 500}) {
  fovy = fovy ?? fov;
  assert(fovy <= pi * 2, 'fovy must be provided in radians');
  return makePerspectiveMatrix(fovy, aspect, near, far);
}
