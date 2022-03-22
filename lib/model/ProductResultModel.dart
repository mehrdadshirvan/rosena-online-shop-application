class ProductResultModel{
  final int _id;
  final String _name;
  final String _name_url;
  final String _ename;
  final int _brand_id;
  final String _brand_name;
  final String _brand_ename_url;
  final int _special;
  final String _avatar;
  final String _rosena_code;
  final String _stock;
  final String _fake;
  final String _price;
  final String _final_price;
  final int _available;
  final int _enterprise_id;
  final String _percent_discount;

  ProductResultModel(
      this._id,
      this._name,
      this._name_url,
      this._ename,
      this._brand_id,
      this._brand_name,
      this._brand_ename_url,
      this._special,
      this._avatar,
      this._rosena_code,
      this._stock,
      this._fake,
      this._price,
      this._final_price,
      this._available,
      this._enterprise_id,
      this._percent_discount);

  String get percent_discount => _percent_discount;

  int get enterprise_id => _enterprise_id;

  int get available => _available;

  String get final_price => _final_price;

  String get price => _price;

  String get fake => _fake;

  String get stock => _stock;

  String get rosena_code => _rosena_code;

  String get avatar => _avatar;

  int get special => _special;

  String get brand_ename_url => _brand_ename_url;

  String get brand_name => _brand_name;

  int get brand_id => _brand_id;

  String get ename => _ename;

  String get name_url => _name_url;

  String get name => _name;

  int get id => _id;
}