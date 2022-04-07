class PageModel {
  int index = 0;
  String title = 'Home';
  final _titles = [
    'Synth Wave',
    'Loyalty Demo',
    'Counter Demo',
    'Calculator Demo',
  ];

  PageModel();

  PageModel copyWith({int? index, String? title}) {
    return PageModel()
      ..index = index ?? this.index
      ..title = title ?? this.title;
  }

  String titleForIndex(int index) => index < _titles.length ? _titles[index] : 'Home';
}
