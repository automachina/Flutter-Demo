import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/actions/counter.dart';
import '/actions/page.dart';
import '/actions/theme.dart';
import '/models/app_state.dart';
import '/models/theme.dart';
import '/pages/calculator.dart';
import '/pages/counter.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

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
              body: IndexedStack(
                index: vm.index,
                children: const [
                  CounterPage(),
                  CalculatorPage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: vm.index,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.unfold_more),
                    label: 'Counter',
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
  final int index;
  final Function(int) onReset;
  final Function(BuildContext) toggleTheme;
  final Function(String) onSetPageTitle;
  final Function(int) onSetPageIndex;

  const _ViewModel(
      {required this.theme,
      required this.title,
      required this.index,
      required this.onReset,
      required this.toggleTheme,
      required this.onSetPageTitle,
      required this.onSetPageIndex});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      theme: store.state.theme,
      title: store.state.page.title,
      index: store.state.page.index,
      onReset: (value) => store.dispatch(ResetAction(value: value)),
      toggleTheme: (context) => store.dispatch(ToggleThemeAction(context)),
      onSetPageTitle: (value) => store.dispatch(UpdatePageTitleAction(value)),
      onSetPageIndex: (value) => store.dispatch(UpdatePageIndexAction(value)),
    );
  }
}
