import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/models/app_state.dart';
import '/models/theme.dart';
import '/pages/root.dart';
import '/store/store.dart';

void main() {
  runApp(MyApp(store: createStore()));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) => MaterialApp(
          title: 'Flutter Demo',
          theme: vm.theme.lightTheme,
          darkTheme: vm.theme.darkTheme,
          themeMode: vm.theme.currentTheme,
          home: const RootPage(),
        ),
      ),
    );
  }
}

class _ViewModel {
  final ThemeModel theme;

  _ViewModel({required this.theme});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(theme: store.state.theme);
  }
}
