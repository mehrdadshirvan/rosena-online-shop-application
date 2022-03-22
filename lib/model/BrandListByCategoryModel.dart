class BrandListByCategoryModel {
  final String _id;
  final String _name;
  final String _ename;
  final String _avatar;

  BrandListByCategoryModel(this._id, this._name, this._ename, this._avatar);

  String get avatar => _avatar;

  String get ename => _ename;

  String get name => _name;

  String get id => _id;
}