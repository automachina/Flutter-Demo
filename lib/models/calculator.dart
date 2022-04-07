enum CalculatorKey {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  plus,
  minus,
  multiply,
  divide,
  equals,
  clear,
  decimal,
  percent,
  plusminus,
  sqrt,
  inverse,
  prenthesis,
  pi,
  e,
  log,
  sin,
  cos,
  tan,
}

class CalculatorModel {
  List<HistoryItem> history = [];
  List<CalculatorKey> keys = [];
  String screen = '';
  String result = '';

  CalculatorModel();

  CalculatorModel.fromValues({
    required this.history,
    required this.keys,
    required this.screen,
    required this.result,
  });

  CalculatorModel inputKey(CalculatorKey key) {
    keys.add(key);
    return this;
  }

  CalculatorModel deleteKey() {
    if (keys.isNotEmpty) {
      keys.removeLast();
    }
    return this;
  }

  CalculatorModel clear() {
    if (keys.isEmpty && screen.isEmpty) {
      history.clear();
    } else {
      keys.clear();
      screen = '';
      result = '';
    }
    return this;
  }

  CalculatorModel appendHistoryAndReset() {
    var newHistory = HistoryItem(
      keys: keys,
      screen: screen,
      result: result,
    );
    return CalculatorModel.fromValues(
      history: [...history, newHistory],
      keys: [],
      screen: result,
      result: ' ',
    );
  }

  CalculatorModel copyWith({
    List<HistoryItem>? history,
    List<CalculatorKey>? keys,
    String? screen,
    String? result,
  }) {
    return CalculatorModel.fromValues(
      history: history ?? this.history,
      keys: keys ?? this.keys,
      screen: screen ?? this.screen,
      result: result ?? this.result,
    );
  }
}

class HistoryItem {
  final List<CalculatorKey> keys;
  final String screen;
  final String result;

  HistoryItem({
    required this.keys,
    required this.screen,
    required this.result,
  });
}
