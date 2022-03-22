import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../inc/ButtomNavigation.dart';
import '../../main.dart';
import '../../model/BasketModel.dart';
import 'ShoppingPage.dart';
import '../auth/LoginPage.dart';
import '../../widget/BasketItem.dart';
import '../../widget/Loading.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final List<BasketModel> _items = [];
  var _result = 0;
  var _access_token, _token_type;
  String _number_value = '1';

  //Loading counter value on start
  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _token_type = prefs.getString('token_type');
    });
    _getCart();
  }

  void _updateCartItem(_cart_id, _product_id, _number_order) async {
    if (_token_type != null && _access_token != null) {
      setState(() {
        _result = 0;
      });
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/app/cart/update', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          "cart_id": _cart_id.toString(),
          "product_id": _product_id.toString(),
          "number_order": _number_order.toString(),
        });
        // print('Response status: ${uriResponse.statusCode}');
        // print('Response body: ${uriResponse.body}');
        if (uriResponse.body == "ok") {
          setState(() {
            _items.removeRange(0, _items.length);
            _getCart();
          });
        } else {
          print('error');
        }
      } finally {
        client.close();
      }
    }
  }

  void _getCart() async {
    if (_token_type != null && _access_token != null) {
      var _authorization = _token_type + ' ' + _access_token.toString();
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/app/cart/get', headers: {
          'Accept': 'application/json',
          'Authorization': _authorization
        });
        if (uriResponse.body.isNotEmpty) {
          var response = uriResponse.bodyBytes;
          setState(() {
            var dataJson = json.decode(utf8.decode(response));
            for (var i in dataJson) {
              var _cartItem = BasketModel(
                i['id'],
                i['product_id'],
                i['enterprise_name'],
                i['product_name'],
                i['avatar'],
                i['number_order'],
                i['final_price'],
                i['price'],
                i['discount'],
                i['available'],
              );
              _items.add(_cartItem);
            }

            setState(() {
              _result = 1;
            });
          });
        } else {
          print('error');
        }
      } finally {
        client.close();
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void _deleteCart(_id) async {
    setState(() {
      _result = 0;
    });
    var client = http.Client();
    try {
      var uriResponse = await client
          .post('https://www.rosena.ir/api/app/cart/delete', headers: {
        'Accept': 'application/json',
        'Authorization': _token_type + ' ' + _access_token
      }, body: {
        'cart_id': _id.toString()
      });
      // print('Response status: ${uriResponse.statusCode}');
      // print('Response body: ${uriResponse.body}');
      if (uriResponse.body == 'ok') {
        setState(() {
          _items.removeWhere((tx) => tx.id == _id);
          _result = 1;
        });
      } else {
        // print('error');
      }
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTokey();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: ApplicationBar(context),
      appBar: AppBar(
        title: Text(
          'سبد خرید شما',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Yekan',
            fontSize: 20
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10,top: 15,bottom: 15),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Yekan',
                        fontSize: 17
                      ),
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.arrow_forward,color: Colors.grey,size: 17,)
                        ),
                        TextSpan(
                          text: 'بازگشت'
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _result == 1
            ? SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _items.isEmpty
                        ? Container(
                            width: size.width,
                            padding: EdgeInsets.only(top: 35, bottom: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'سبد خرید شما خالی میباشد',
                                  style: TextStyle(
                                      fontFamily: 'Yekan',
                                      fontSize: 20,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Container(
                                      width: size.width,
                                      child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              RaisedButton(
                                                onPressed: () {
                                                  return Navigator.of(context)
                                                      .push(PageRouteBuilder(
                                                          transitionDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                          pageBuilder: (BuildContext
                                                                  context,
                                                              Animation<double>
                                                                  animation,
                                                              Animation<double>
                                                                  secondAnimation) {
                                                            return Main();
                                                          }));
                                                },
                                                textColor: Colors.white,
                                                color: Colors.pink,
                                                child: const Text(
                                                  'بازگشت به خانه',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Yekan',
                                                    height: 2,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return BasketItem(_items[index], _deleteCart,
                                      _updateCartItem, _number_value);
                                },
                                itemCount: _items.length,
                              ),
                            ),
                          ),
                  ],
                ),
              )
            : Loading('در حال بررسی'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: _items.isNotEmpty
            ? Container(
                height: 110,
                child: Column(
                  children: <Widget>[
                    BottomNavigationBasket(),
                    ButtomNavigation(),
                  ],
                ),
              )
            : Container(
                height: 50,
                child: Column(
                  children: <Widget>[
                    ButtomNavigation(),
                  ],
                ),
              ),
      ),
    );
  }
}

class BottomNavigationBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      color: Colors.white,
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: RaisedButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShoppingPage())),
                    },
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'تایید و تکمیل خرید'),
                          TextSpan(
                            text: '   ',
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 0, left: 15),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
