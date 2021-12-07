class PageModel {
  int index = 0;
  String title = 'Home';
  final _titles = ['Counter Demo', 'Calculator Demo'];

  PageModel();

  copyWith({int? index, String? title}) {
    return PageModel()
      ..index = index ?? this.index
      ..title = title ?? this.title;
  }

  String titleForIndex(int index) => _titles[index];
}
