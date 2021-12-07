class CounterModel {
  int value = 0;
  int increment = 1;

  CounterModel();

  CounterModel.fromValues({this.value = 0, this.increment = 1});

  CounterModel copyWith({int? value, int? increment}) {
    return CounterModel.fromValues(
      value: value ?? this.value,
      increment: increment ?? this.increment,
    );
  }

  CounterModel increase() {
    value += increment;
    return this;
  }

  CounterModel decrease() {
    value -= increment;
    return this;
  }

  CounterModel reset() {
    value = 0;
    return this;
  }
}
