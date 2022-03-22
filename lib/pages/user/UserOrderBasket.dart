import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../inc/ApplicationBarJustBackBtn.dart';
import '../../inc/ButtomNavigation.dart';
import '../../model/OrderModelBasket.dart';
import '../../widget/Loading.dart';

class UserOrderBasket extends StatefulWidget {
  final String _order_id;

  UserOrderBasket(this._order_id);

  @override
  _UserOrderBasketState createState() => _UserOrderBasketState();
}

class _UserOrderBasketState extends State<UserOrderBasket> {
  final List<OrderModelBasket> _items = [];
  var _access_token, _token_type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTokey();
  }

  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _token_type = prefs.getString('token_type');
      _getItems();
    });

  }

  void _getItems() async {
    if(_token_type != null && _access_token != null) {
      var client = http.Client();
      try {
        var uriResponse = await client.post('https://www.rosena.ir/api/profile/order/basket', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        },body: {'order_id': widget._order_id.toString()});
        // print('Response status: ${uriResponse.statusCode}');
        // print('Response body: ${uriResponse.body}');
        if (uriResponse.body.isNotEmpty) {
          var response = uriResponse.bodyBytes;
          setState(() {
            var dataJson = json.decode(utf8.decode(response));
            for (var i in dataJson) {
              var _pitem = OrderModelBasket(
                i['name'],
                i['avatar'],
                i['number_order'],
                i['final_price'],
              );
              _items.add(_pitem);
            }
            print(_items);
          });
        }
      } finally {
        client.close();
      }
    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SingleChildScrollView(
        child: _items.isNotEmpty ? Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return OrderBasketItem(_items[index]);
            },
            itemCount: _items.length,
          ),
        ) : Loading('درحال دریافت'),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}

class OrderBasketItem extends StatelessWidget {
  final OrderModelBasket _basket;
  OrderBasketItem(this._basket);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Image.network(
                'https://www.rosena.ir' + _basket.avatar.toString()),
          ),
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _basket.name.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontFamily: 'Yekan',
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تعداد: ' + _basket.number_order.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontFamily: 'Yekan',
                      height: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'قیمت کل: ' + _basket.final_price.toString() + ' ' + 'تومان',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

