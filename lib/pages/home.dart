import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/actions/counter.dart';
import '/actions/page.dart';
import '/actions/theme.dart';
import '/models/app_state.dart';
import '/models/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) => Scaffold(
              appBar: AppBar(
                title: Text(vm.title),
                actions: [
                  IconButton(
                    icon: Icon(vm.theme.currentTheme == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode),
                    onPressed: () => vm.toggleTheme(context),
                  ),
                ],
              ),
              body: Center(
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
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => vm.onReset(0),
                tooltip: 'Reset',
                child: const Icon(Icons.refresh),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calculate),
                    label: 'Calculator',
                  )
                ],
                onTap: (index) => vm.onSetPageIndex(index),
              ),
            ));
  }
}

class _ViewModel {
  final ThemeModel theme;
  final String title;
  final int count;
  final int increment;
  final Function(int) onUpdateIncrement;
  final Function(int) onIncrement;
  final Function(int) onDecrement;
  final Function(int) onReset;
  final Function(BuildContext) toggleTheme;
  final Function(String) onSetPageTitle;
  final Function(int) onSetPageIndex;

  const _ViewModel(
      {required this.theme,
      required this.title,
      required this.count,
      required this.increment,
      required this.onUpdateIncrement,
      required this.onIncrement,
      required this.onDecrement,
      required this.onReset,
      required this.toggleTheme,
      required this.onSetPageTitle,
      required this.onSetPageIndex});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      theme: store.state.theme,
      title: store.state.page.title,
      count: store.state.counter.value,
      increment: store.state.counter.increment,
      onUpdateIncrement: (value) => store.dispatch(UpdateIncrementAction(value)),
      onIncrement: (value) => store.dispatch(IncrementAction(value)),
      onDecrement: (value) => store.dispatch(DecrementAction(value)),
      onReset: (value) => store.dispatch(ResetAction(value: value)),
      toggleTheme: (context) => store.dispatch(ToggleThemeAction(context)),
      onSetPageTitle: (value) => store.dispatch(UpdatePageTitleAction(value)),
      onSetPageIndex: (value) => store.dispatch(UpdatePageIndexAction(value)),
    );
  }
}
