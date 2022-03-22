class BrandModel{
  final String _id;
  final String _name;
  final String _ename;
  final String _avatar;
  final String _content;

  BrandModel(this._id, this._name, this._ename, this._avatar, this._content);

  String get content => _content;

  String get avatar => _avatar;

  String get ename => _ename;

  String get name => _name;

  String get id => _id;
}

