import '/utilities/string.dart';
import '/models/calculator.dart';

String calculatorKeysToScreen(List<CalculatorKey> keys) {
  var screen = '';
  var lastChar = '';

  for (var key in keys) {
    if (key == CalculatorKey.plus) {
      if (lastChar == '+') continue;
      screen += '+';
    } else if (key == CalculatorKey.minus) {
      if (lastChar == '-') continue;
      screen += '-';
    } else if (key == CalculatorKey.multiply) {
      if (lastChar == '✕') continue;
      screen += '✕'; // '·'; // '✕';
    } else if (key == CalculatorKey.divide) {
      if (lastChar == '/') continue;
      screen += '/';
    } else if (key == CalculatorKey.decimal) {
      if (screen.isEmpty || !RegExp(r'[0-9\.\)]$').hasMatch(screen)) {
        screen += '0.';
      } else if (RegExp(r'(-?)(0|([1-9][0-9]*))((\.)|(\.[0-9]+)?)$').hasMatch(screen + '.')) {
        screen += '.';
      }
    } else if (key == CalculatorKey.prenthesis) {
      if (screen.isEmpty || lastChar == '(') {
        screen += '(';
      } else if (screen.contains('(')) {
        var openingParens = '('.allMatches(screen).length;
        var closingParens = ')'.allMatches(screen).length;
        if (openingParens > closingParens) {
          screen += ')';
        } else {
          screen += '(';
        }
      } else if (RegExp(r'[^0-9\)\.]$').hasMatch(lastChar)) {
        screen += '(';
      }
    } else if (key == CalculatorKey.percent) {
      // TODO: implement percent function
      if (screen.isNotEmpty) {
        screen += '%';
      }
    } else if (lastChar != ')') {
      screen += key.index.toString();
    }
    lastChar = screen.isNotEmpty ? screen[screen.length - 1] : '';
  }
  return screen;
}

String calculatorKeysToExpression(List<CalculatorKey> keys) {
  var expression = '';
  var lastChar = '';

  for (var key in keys) {
    if (key == CalculatorKey.plus) {
      if (lastChar == '+') continue;
      expression += '+';
    } else if (key == CalculatorKey.minus) {
      if (lastChar == '-') continue;
      expression += '-';
    } else if (key == CalculatorKey.multiply) {
      if (lastChar == '*') continue;
      expression += '*';
    } else if (key == CalculatorKey.divide) {
      if (lastChar == '/') continue;
      expression += '/';
    } else if (key == CalculatorKey.decimal) {
      if (expression.isEmpty || !RegExp(r'[0-9\.\)]$').hasMatch(expression)) {
        expression += '0.';
      } else if (RegExp(r'(-?)(0|([1-9][0-9]*))((\.)|(\.[0-9]+)?)$').hasMatch(expression + '.')) {
        expression += '.';
      }
    } else if (key == CalculatorKey.prenthesis) {
      if (expression.isEmpty || lastChar == '(') {
        expression += '(';
      } else if (expression.contains('(')) {
        var openingParens = '('.allMatches(expression).length;
        var closingParens = ')'.allMatches(expression).length;
        if (openingParens > closingParens) {
          expression += ')';
        } else {
          expression += '(';
        }
      } else if (RegExp(r'[^0-9\)\.]$').hasMatch(lastChar)) {
        expression += '(';
      }
    } else if (key == CalculatorKey.percent) {
      // TODO: implement percent function
      var lastNum = expression.lastNumberInString();
      if (lastNum != null) {
        expression = expression.replaceFirst(RegExp('$lastNum\$'), '($lastNum / 100)');
      }
    } else if (lastChar != ')') {
      expression += key.index.toString();
    }
    lastChar = expression.isNotEmpty ? expression[expression.length - 1] : '';
  }
  return expression;
}
