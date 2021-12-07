import 'package:flutter/material.dart';
import '/utilities/string.dart';

InlineSpan lineBreak({int lines = 1}) =>
    lines <= 1 ? const TextSpan(text: '\n') : TextSpan(text: '\n'.duplicate(times: lines));
