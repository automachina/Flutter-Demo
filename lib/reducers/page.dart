import '/actions/page.dart';
import '/models/page.dart';

PageModel pageReducer(PageModel page, dynamic action) {
  if (action is UpdatePageTitleAction) {
    return page.copyWith(title: action.title);
  } else if (action is UpdatePageIndexAction) {
    return page.copyWith(index: action.index, title: page.titleForIndex(action.index));
  }
  return page;
}
