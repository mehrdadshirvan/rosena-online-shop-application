class BasketModel{
  final int _id;
  final int _product_id;
  final String _enterprise_name;
  final String _product_name;
  final String _avatar;
  final int _number_order;
  final int _final_price;
  final int _price;
  final int _discount;
  final int _available;

  BasketModel(
      this._id,
      this._product_id,
      this._enterprise_name,
      this._product_name,
      this._avatar,
      this._number_order,
      this._final_price,
      this._price,
      this._discount,
      this._available);

  int get available => _available;

  int get discount => _discount;

  int get price => _price;

  int get final_price => _final_price;

  int get number_order => _number_order;

  String get avatar => _avatar;

  String get product_name => _product_name;

  String get enterprise_name => _enterprise_name;

  int get product_id => _product_id;

  int get id => _id;
}