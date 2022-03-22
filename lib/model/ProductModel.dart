class ProductPageModel{
  final String _id;
  final String _name;
  final String _ename;
  final String _brand_id;
  final String _avatar;
  final String _short_description;
  final String _content;
  final String _rosena_code;
  final String _only_qazvin;
  final String _stock;
  final String _fake;
  final String _video;

  ProductPageModel(
      this._id,
      this._name,
      this._ename,
      this._brand_id,
      this._avatar,
      this._short_description,
      this._content,
      this._rosena_code,
      this._only_qazvin,
      this._stock,
      this._fake,
      this._video);

  String get video => _video;

  String get fake => _fake;

  String get stock => _stock;

  String get only_qazvin => _only_qazvin;

  String get rosena_code => _rosena_code;

  String get content => _content;

  String get short_description => _short_description;

  String get avatar => _avatar;

  String get brand_id => _brand_id;

  String get ename => _ename;

  String get name => _name;

  String get id => _id;
}