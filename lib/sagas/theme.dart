import 'package:redux_saga/redux_saga.dart';
import '/actions/theme.dart';

toggleThemeAsync({dynamic action}) sync* {
  yield Call(print, args: ['toggleThemeAsync']);
}

themeWatcher() sync* {
  yield TakeEvery(toggleThemeAsync, pattern: ToggleThemeAction);
}
