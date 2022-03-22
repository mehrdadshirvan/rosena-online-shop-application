class ProductPageCategories{
  final String _id;
  final String _name;
  final String _ename_url;

  ProductPageCategories(this._id, this._name, this._ename_url);

  String get ename_url => _ename_url;

  String get name => _name;

  String get id => _id;
}