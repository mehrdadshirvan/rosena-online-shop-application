class ProductStoreModel{
  final String _product_id;
  final String _enterprise_id;
  final String _name;
  final String _ename;
  final String _send_time;
  final String _avatar;
  final String _garanti;
  final String _available;
  final String _price;
  final String _final_price;
  final String _discount_percent;

  ProductStoreModel(
      this._product_id,
      this._enterprise_id,
      this._name,
      this._ename,
      this._send_time,
      this._avatar,
      this._garanti,
      this._available,
      this._price,
      this._final_price,
      this._discount_percent);

  String get discount_percent => _discount_percent;

  String get final_price => _final_price;

  String get price => _price;

  String get available => _available;

  String get garanti => _garanti;

  String get avatar => _avatar;

  String get send_time => _send_time;

  String get ename => _ename;

  String get name => _name;

  String get enterprise_id => _enterprise_id;

  String get product_id => _product_id;
}