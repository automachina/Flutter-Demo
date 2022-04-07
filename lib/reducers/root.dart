import 'package:test_drive/reducers/loyalty.dart';

import '/models/app_state.dart';
import '/reducers/calculator.dart';
import '/reducers/counter.dart';
import '/reducers/page.dart';
import '/reducers/theme.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    counter: counterReducer(state.counter, action),
    theme: themeReducer(state.theme, action),
    page: pageReducer(state.page, action),
    calculator: calculatorReducer(state.calculator, action),
    loyalty: loyaltyReducer(state.loyalty, action),
  );
}
