import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/actions/counter.dart';
import '/models/app_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => vm.onIncrement(1),
                tooltip: "Increment",
              ),
            ),
            Text(
              '${vm.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: FloatingActionButton(
                child: const Icon(Icons.remove),
                onPressed: () => vm.onDecrement(1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: vm.increment.toDouble(),
                  onChanged: (value) => vm.onUpdateIncrement(value.toInt()),
                  min: 1,
                  max: 10,
                  divisions: 9,
                )
              ],
            ),
            Text(
              '${vm.increment}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
                padding: const EdgeInsets.only(top: 30),
                child: FloatingActionButton(
                    onPressed: () => vm.onReset(0), child: const Icon(Icons.refresh))),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final int count;
  final int increment;
  final Function(int) onUpdateIncrement;
  final Function(int) onIncrement;
  final Function(int) onDecrement;
  final Function(int) onReset;

  const _ViewModel({
    required this.count,
    required this.increment,
    required this.onUpdateIncrement,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      count: store.state.counter.value,
      increment: store.state.counter.increment,
      onUpdateIncrement: (value) => store.dispatch(UpdateIncrementAction(value)),
      onIncrement: (value) => store.dispatch(IncrementAction(value)),
      onDecrement: (value) => store.dispatch(DecrementAction(value)),
      onReset: (value) => store.dispatch(ResetAction(value: value)),
    );
  }
}
