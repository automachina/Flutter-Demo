import '../actions/calculator.dart';
import '/models/calculator.dart';

CalculatorModel calculatorReducer(CalculatorModel state, dynamic action) {
  if (action is InputCalculatorKeyAction) {
    return state.inputKey(action.key);
  } else if (action is ScreenUpdatedAction) {
    return state.copyWith(screen: action.screen);
  } else if (action is RemoveCalculatorKeyAction) {
    return state.deleteKey();
  } else if (action is ClearCalculatorAction) {
    return state.clear();
  } else if (action is CompleteCalculationAction) {
    return state.appendHistoryAndReset();
  } else if (action is UpdateResultAction) {
    return state.copyWith(result: action.result);
  }
  return state;
}
