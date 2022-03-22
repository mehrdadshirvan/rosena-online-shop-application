class OrderModelBasket{
  final String _name;
  final String _avatar;
  final String _number_order;
  final String _final_price;

  OrderModelBasket(this._name, this._avatar, this._number_order,
      this._final_price);

  String get final_price => _final_price;

  String get number_order => _number_order;

  String get avatar => _avatar;

  String get name => _name;
}