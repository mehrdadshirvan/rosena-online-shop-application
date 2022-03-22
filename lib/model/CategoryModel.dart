
class CategoryModel {
  final int _id;
  final String _name;
  final String _ename;
  final String _ename_url;
  final int _parent_id;
  final String _img_url_1;
  final String _get_sub_category;



  CategoryModel(
      this._id,
      this._name,
      this._ename,
      this._ename_url,
      this._parent_id,
      this._img_url_1,
      this._get_sub_category
      );

  int get id => _id;
  String get name => _name;
  String get ename => _ename;
  String get ename_url => _ename_url;
  int get parent_id => _parent_id;
  String get img_url_1 => _img_url_1;
  String get get_sub_category => _get_sub_category;



}
