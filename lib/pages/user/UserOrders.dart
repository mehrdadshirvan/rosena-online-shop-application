import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../inc/ApplicationBarJustBackBtn.dart';
import '../../inc/ButtomNavigation.dart';
import '../../model/OrderModel.dart';
import '../../widget/Loading.dart';
import '../../widget/OrderItem.dart';


class UserOrders extends StatefulWidget {
  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  final List<OrderModel> _items = [];
  var _access_token, _token_type;
  var _result = 0;
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
      print('start connection');
      var client = http.Client();
      try {
        var uriResponse = await client.post('https://www.rosena.ir/api/profile/order', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        });
        setState(() {
          _result = 1;
        });
        if (uriResponse.body.isNotEmpty) {
          var response = uriResponse.bodyBytes;
          setState(() {
            var dataJson = json.decode(utf8.decode(response));
            for (var i in dataJson) {
              var pitem = OrderModel(
                i['id'],
                i['gateway'],
                i['factor_number'],
                i['pay_type'],
                i['send_price'],
                i['product_price'],
                i['final_price'],
                i['order_position'],
                i['post_send_number'],
                i['jdate'],
                i['re_name'],
                i['re_mobile'],
                i['re_country'],
                i['re_city'],
                i['re_address'],
                i['re_post_code'],
              );
              _items.add(pitem);
            }
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
        child:  _result == 1 ? Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: _items.isNotEmpty ? Container(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return OrderItem(_items[index]);
              },
              itemCount: _items.length,
            ),
          ) : Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'محصولی یافت نشد!',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Yekan',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        ) : Loading('در حال دریافت!'),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}
