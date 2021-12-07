import '/models/calculator.dart';

class InputCalculatorKeyAction {
  final CalculatorKey key;

  const InputCalculatorKeyAction(this.key);
}

class UpdateScreenAction {}

class ScreenUpdatedAction {
  final String screen;

  const ScreenUpdatedAction(this.screen);
}

class UpdateResultAction {
  final String result;

  const UpdateResultAction(this.result);
}

class RemoveCalculatorKeyAction {}

class ExecuteCalculationAction {}

class CompleteCalculationAction {}

class ClearCalculatorAction {}
