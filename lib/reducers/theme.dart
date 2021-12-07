import '/actions/theme.dart';
import '/models/theme.dart';

ThemeModel themeReducer(ThemeModel state, dynamic action) {
  if (action is ToggleThemeAction) {
    return state.toggleTheme(action.context);
  }
  return state;
}
