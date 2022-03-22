import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../inc/ApplicationBarJustBackBtn.dart';
import 'BasketPage.dart';
import '../../widget/Loading.dart';



class FinalFactorPage extends StatefulWidget {


  @override
  _FinalFactorPageState createState() => _FinalFactorPageState();
}

class _FinalFactorPageState extends State<FinalFactorPage> {
  String _pay_link = "https://www.rosena.ir";
  Future<void> _launched;
  final List<FactorModel> _items = [];
  var _access_token, _token_type, _address_array;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadTokey();
  }

  //Loading counter value on start
  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _token_type = prefs.getString('token_type');
      _address_array = prefs.getString('address_array');
      _getFactor();
    });

  }

  void _getFactor() async {
    if (_token_type != null && _access_token != null) {
      var _authorization = _token_type + ' ' + _access_token.toString();
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/shipping/factor', headers: {
          'Accept': 'application/json',
          'Authorization': _authorization
        }, body: {'user_address': _address_array});
        if (uriResponse.body.isNotEmpty) {
          var response = uriResponse.body;
          setState(() {
            var dataJson = json.decode(response);
            for (var i in dataJson) {
              var _it = FactorModel(
                i['product_with_discount'].toString(),
                i['sum_price'].toString(),
                i['final_discount'].toString(),
                i['pick_price'].toString(),
                i['final_price'].toString(),
                i['weight_cart'].toString(),
                i['link_payment'].toString(),
              );
              _items.add(_it);
            }
            setState(() {
              _pay_link = _items[0].link_payment.toString();
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
          .push(MaterialPageRoute(builder: (context) => BasketPage()));
    }
  }

  void _checkAndCountinue(link) async {
    launch(link.toString());
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SingleChildScrollView(
        child: _items.isNotEmpty ? Container(
          alignment: Alignment.center,
          height: _mediaQuery.size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (_items.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,

                      padding:
                          EdgeInsets.only(top: 20, bottom: 20, left: 22, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding:
                            EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 0),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Image.asset('assets/images/Rosena_ir.png', width: 350),
                          ),
                          Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            height: 75,
                            child: Text(
                              'فاکتور پرداخت',
                              style: TextStyle(
                                height: 1.5,
                                fontFamily: "Yekan",
                                fontSize: 25,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  height: 1.5),
                              children: [
                                TextSpan(text: 'مبلغ کل خرید: '),
                                TextSpan(
                                  text: _items[0].sum_price.toString() + ' ',
                                ),
                                TextSpan(text: 'تومان'),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  height: 1.5),
                              children: [
                                TextSpan(text: 'مبلغ کل تخفیف: '),
                                TextSpan(
                                  text: _items[0].final_discount.toString() + ' ',
                                ),
                                TextSpan(text: 'تومان'),
                              ],
                            ),
                          ),
                          SizedBox(height:10,),
                          Divider(height: 2,),
                          SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  height: 1.5),
                              children: [
                                TextSpan(text: 'مبلغ خرید محصولات: '),
                                TextSpan(
                                  text: _items[0].product_with_discount.toString() + ' ',
                                ),
                                TextSpan(text: 'تومان'),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  height: 1.5),
                              children: [
                                TextSpan(text: 'هزینه ارسال: '),
                                TextSpan(
                                  text: _items[0].pick_price.toString() + ' ',
                                ),
                                TextSpan(text: 'تومان'),
                              ],
                            ),
                          ),
                          SizedBox(height:10,),
                          Divider(height: 2,),
                          SizedBox(height: 10,),
                          RichText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                  height: 1.5),
                              children: [
                                TextSpan(text: 'مبلغ قابل پرداخت: '),
                                TextSpan(
                                  text: _items[0].final_price.toString() + ' ',
                                ),
                                TextSpan(text: 'تومان'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ) : Loading('درحال دریافت'),
      ),
      bottomNavigationBar: BottomNavigationFactor(_checkAndCountinue,_pay_link.toString()),
    );
  }
}

class BottomNavigationFactor extends StatelessWidget {
  final Function _checkAndCountinue;
  final String _link;
  BottomNavigationFactor(this._checkAndCountinue,this._link);

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
                    onPressed: () => _checkAndCountinue(_link),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'ورود به درگاه بانک'),
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

class FactorModel {
  final String _product_with_discount;
  final String _sum_price;
  final String _final_discount;
  final String _pick_price;
  final String _final_price;
  final String _weight_cart;
  final String _link_payment;

  FactorModel(this._product_with_discount,this._sum_price, this._final_discount, this._pick_price,
      this._final_price, this._weight_cart, this._link_payment);

  String get product_with_discount => _product_with_discount;
  String get link_payment => _link_payment;

  String get weight_cart => _weight_cart;

  String get final_price => _final_price;

  String get pick_price => _pick_price;

  String get final_discount => _final_discount;

  String get sum_price => _sum_price;
}
