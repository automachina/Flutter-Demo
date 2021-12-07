import 'package:redux_saga/redux_saga.dart';
import '/sagas/calculator.dart';
import '/sagas/counter.dart';
import '/sagas/theme.dart';

rootSaga() sync* {
  yield Call(print, args: ['root saga starting']);
  yield All({
    #watchCounter: Fork(counterWatcher),
    #watchTheme: Fork(themeWatcher),
    #watchCalculator: Fork(calculatorWatcher),
  });
}
