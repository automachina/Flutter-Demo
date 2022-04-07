import 'package:complex/complex.dart';

int mandelbrot({
  Complex c = Complex.zero,
  int maxIterations = 100,
}) {
  Complex z = Complex.zero;
  int n = 0;
  while (z.abs() < 2 && n < maxIterations) {
    z = z * z + c;
    n++;
  }
  return n;
}
