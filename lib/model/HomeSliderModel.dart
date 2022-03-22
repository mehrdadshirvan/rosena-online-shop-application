class HomeSliderModel {
  final String _title;
  final String _img_url;
  final String _link_to;
  final String _category;
  final String _brand;

  HomeSliderModel(
      this._title, this._img_url, this._link_to, this._category, this._brand);

  String get brand => _brand;

  String get category => _category;

  String get link_to => _link_to;

  String get img_url => _img_url;

  String get title => _title;
}
