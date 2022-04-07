import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_drive/pages/loyalty.dart';
import 'package:test_drive/pages/mandelbrot.dart';
import 'package:test_drive/pages/synth.dart';
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
    const views = <Widget>[
      MandelbrotPage(),
      SynthPage(),
      LoyaltyPage(),
      CalculatorPage(),
      CounterPage(),
    ];
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
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: views[vm.index],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey,
                elevation: 3,
                currentIndex: vm.index,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.filter_vintage_sharp),
                    label: 'Mandelbrot',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wb_twilight),
                    label: 'Synth',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.loyalty),
                    label: 'Loyalty',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calculate),
                    label: 'Calculator',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.unfold_more),
                    label: 'Counter',
                  ),
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
