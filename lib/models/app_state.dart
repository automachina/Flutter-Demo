import '/models/calculator.dart';
import '/models/counter.dart';
import '/models/page.dart';
import '/models/theme.dart';

class AppState {
  final CounterModel counter;
  final ThemeModel theme;
  final PageModel page;
  final CalculatorModel calculator;

  const AppState({
    required this.counter,
    required this.theme,
    required this.page,
    required this.calculator,
  });

  factory AppState.initial() {
    return AppState(
      counter: CounterModel(),
      theme: ThemeModel(),
      page: PageModel(),
      calculator: CalculatorModel(),
    );
  }
}
