String removeDecimalZeroFormat(double n) => n.toString().replaceAll(RegExp(r'[0\.]*$'), '');
