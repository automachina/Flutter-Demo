import 'package:math_expressions/math_expressions.dart';
import 'package:redux_saga/redux_saga.dart';
import 'package:test_drive/utilities/calculator.dart';
import '/models/app_state.dart';
import '/models/calculator.dart';
import '/actions/calculator.dart';
import '../utilities/number.dart';

List<CalculatorKey> getKeys(AppState state) => state.calculator.keys;
String getScreen(AppState state) => state.calculator.screen;
String getResult(AppState state) => state.calculator.result;

inputKey({dynamic action}) sync* {
  if (action is InputCalculatorKeyAction) {
    yield Call(print, args: ['inputKey: $action.key']);
  }
  yield Put(UpdateScreenAction());
}

removeKey({dynamic action}) sync* {
  yield Call(print, args: ['removeKey']);
  yield Put(UpdateScreenAction());
}

updateScreen({dynamic action}) sync* {
  yield Call(print, args: ['updateScreen']);
  var keysResult = Result<List<CalculatorKey>>();
  yield Select(selector: getKeys, result: keysResult);
  var keys = keysResult.value ?? [];
  var screen = calculatorKeysToScreen(keys);
  var expression = calculatorKeysToExpression(keys);

  print('updateScreen: $screen');
  print('updateExpression: $expression');

  yield Put(ScreenUpdatedAction(screen));

  yield Try(() sync* {
    var result = '';
    if (expression.isNotEmpty) {
      var p = Parser();
      var exp = p.parse(expression);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      print('updateEval: $eval');
      if (eval is double) {
        result = removeDecimalZeroFormat(eval);
      }
    }
    print('updateResult: $result');
    yield Put(UpdateResultAction(result));
  }, Catch: (e, s) sync* {
    print('Evaluation Failed: $e');
  });
}

executeCalculation({dynamic action}) sync* {
  yield Call(print, args: ['executeCalculation']);
  yield Put(CompleteCalculationAction());
}

calculatorWatcher({dynamic action}) sync* {
  yield TakeEvery(inputKey, pattern: InputCalculatorKeyAction);
  yield TakeEvery(removeKey, pattern: RemoveCalculatorKeyAction);
  yield TakeEvery(updateScreen, pattern: UpdateScreenAction);
  yield TakeEvery(executeCalculation, pattern: ExecuteCalculationAction);
}
