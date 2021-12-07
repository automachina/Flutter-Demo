class IncrementAction {
  final int value;

  IncrementAction(this.value);
}

class DecrementAction {
  final int value;

  DecrementAction(this.value);
}

class ResetAction {
  final int value;

  ResetAction({this.value = 0});
}

class UpdateIncrementAction {
  final int value;

  UpdateIncrementAction(this.value);
}
