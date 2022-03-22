class OrderModel {
  final int _id;
  final String _gateway;
  final String _factor_number;
  final String _pay_type;
  final String _send_price;
  final String _product_price;
  final String _final_price;
  final String _order_position;
  final String _post_send_number;
  final String _jdate;
  final String _re_name;
  final String _re_mobile;
  final String _re_country;
  final String _re_city;
  final String _re_address;
  final String _re_post_code;

  OrderModel(
      this._id,
      this._gateway,
      this._factor_number,
      this._pay_type,
      this._send_price,
      this._product_price,
      this._final_price,
      this._order_position,
      this._post_send_number,
      this._jdate,
      this._re_name,
      this._re_mobile,
      this._re_country,
      this._re_city,
      this._re_address,
      this._re_post_code);

  String get re_post_code => _re_post_code;

  String get re_address => _re_address;

  String get re_city => _re_city;

  String get re_country => _re_country;

  String get re_mobile => _re_mobile;

  String get re_name => _re_name;

  String get jdate => _jdate;

  String get post_send_number => _post_send_number;

  String get order_position => _order_position;

  String get final_price => _final_price;

  String get product_price => _product_price;

  String get send_price => _send_price;

  String get pay_type => _pay_type;

  String get factor_number => _factor_number;

  String get gateway => _gateway;

  int get id => _id;
}