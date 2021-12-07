extension StringExtensions on String {
  String duplicate({int times = 1}) {
    if (times <= 1) return this;
    return List.generate(times, (index) => this).reduce((value, element) => value + this);
  }

  String? lastNumberInString() {
    var numRegex = RegExp(r'(-?)(0|([1-9][0-9]*))(\.[0-9]+)?$');
    if (numRegex.hasMatch(this)) {
      var lastNum = numRegex.allMatches(this).last.group(0);
      return lastNum;
    }
    return null;
  }

  List<String>? numbersInString() {
    var numRegex = RegExp(r'(-?)(0|([1-9][0-9]*))(\.[0-9]+)?$');
    if (numRegex.hasMatch(this)) {
      var lastNum = numRegex
          .allMatches(this)
          .map((match) => match.group(0))
          .where((n) => n != null)
          .map((n) => n as String)
          .toList();
      return lastNum;
    }
    return null;
  }
}
