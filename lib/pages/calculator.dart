import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_drive/components/text.dart';
import '/actions/calculator.dart';
import '../components/calculator/keypad.dart';
import '/models/app_state.dart';
import '/models/calculator.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomRight,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(children: [
                      TextSpan(text: vm.screen, style: const TextStyle(fontSize: 40)),
                      lineBreak(),
                      TextSpan(text: vm.result, style: const TextStyle(fontSize: 25)),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Keypad(
              onKeyPressed: vm.onKeyPressed,
              onClear: vm.onClear,
              onEquals: vm.onCalculate,
              onBackspace: vm.onKeyRemoved,
            ),
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final String screen;
  final String result;
  final List<CalculatorKey> keys;
  final List<HistoryItem> history;
  final Function(CalculatorKey) onKeyPressed;
  final Function() onKeyRemoved;
  final Function() onCalculate;
  final Function() onClear;

  const _ViewModel({
    required this.screen,
    required this.result,
    required this.keys,
    required this.history,
    required this.onKeyPressed,
    required this.onKeyRemoved,
    required this.onCalculate,
    required this.onClear,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final calculator = store.state.calculator;
    return _ViewModel(
      screen: calculator.screen,
      result: calculator.result,
      keys: calculator.keys,
      history: calculator.history,
      onKeyPressed: (key) => store.dispatch(InputCalculatorKeyAction(key)),
      onKeyRemoved: () => store.dispatch(RemoveCalculatorKeyAction()),
      onCalculate: () => store.dispatch(ExecuteCalculationAction()),
      onClear: () => store.dispatch(ClearCalculatorAction()),
    );
  }
}
