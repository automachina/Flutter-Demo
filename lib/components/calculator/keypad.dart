import 'package:flutter/material.dart';
import '/models/calculator.dart';
import '/utilities/color.dart';

class Keypad extends StatelessWidget {
  final Function(CalculatorKey) onKeyPressed;
  final Function onClear;
  final Function onBackspace;
  final Function onEquals;
  const Keypad({
    Key? key,
    required this.onKeyPressed,
    required this.onClear,
    required this.onBackspace,
    required this.onEquals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _KeypadButton(
              child: const Text('AC', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.purple.shade100),
              onPressed: () => onClear(),
            ),
            _KeypadButton(
              child: const Text('()', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.prenthesis),
            ),
            _KeypadButton(
              child: const Text('%', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.percent),
            ),
            _KeypadButton(
              child: const Text('÷', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.divide),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _KeypadButton(
              child: const Text('7', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.seven),
            ),
            _KeypadButton(
              child: const Text('8', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.eight),
            ),
            _KeypadButton(
              child: const Text('9', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.nine),
            ),
            _KeypadButton(
              child: const Text('✕', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.multiply),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _KeypadButton(
              child: const Text('4', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.four),
            ),
            _KeypadButton(
              child: const Text('5', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.five),
            ),
            _KeypadButton(
              child: const Text('6', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.six),
            ),
            _KeypadButton(
              child: const Text('-', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.minus),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _KeypadButton(
              child: const Text('1', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.one),
            ),
            _KeypadButton(
              child: const Text('2', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.two),
            ),
            _KeypadButton(
              child: const Text('3', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.three),
            ),
            _KeypadButton(
              child: const Text('+', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onKeyPressed(CalculatorKey.plus),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _KeypadButton(
              child: const Text('0', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.zero),
            ),
            _KeypadButton(
              child: const Text('.', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onKeyPressed(CalculatorKey.decimal),
            ),
            _KeypadButton(
              child: const Icon(Icons.backspace_outlined, size: 20),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.grey.shade800),
              forgroundColor: context.themedColor(Colors.white, Colors.white),
              onPressed: () => onBackspace(),
            ),
            _KeypadButton(
              child: const Text('=', style: TextStyle(fontSize: 20)),
              height: 80,
              width: 80,
              backgroundColor: context.themedColor(Colors.blue, Colors.blueGrey.shade400),
              onPressed: () => onEquals(),
            ),
          ]),
        )
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? forgroundColor;
  final Color? backgroundColor;

  const _KeypadButton({
    Key? key,
    required this.height,
    required this.width,
    this.child,
    required this.onPressed,
    this.forgroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        child: FloatingActionButton(
          child: child,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          foregroundColor: forgroundColor,
        ),
      ),
    );
  }
}
