import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../inc/ButtomNavigation.dart';
import '../../model/ProductResultModel.dart';
import '../../widget/Loading.dart';
import '../../widget/ProductItem.dart';


class UserLove extends StatefulWidget {
  @override
  _UserLoveState createState() => _UserLoveState();
}

class _UserLoveState extends State<UserLove> {
  final List<ProductResultModel> _productItemsLove = [];
  final List<ProductResultModel> _productItemsNoti = [];
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
      _getItems('love');
      _getItems('noti');
    });
  }

  void _getItems(code) async {
    if (_token_type != null && _access_token != null) {
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/profile/'+code.toString(), headers: {
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
              var pitem = ProductResultModel(
                i['id'],
                i['name'],
                i['name_url'],
                i['ename'],
                i['brand_id'],
                i['brand_name'],
                i['brand_ename_url'],
                i['special'],
                i['avatar'],
                i['rosena_code'],
                i['stock'],
                i['fake'],
                i['price'],
                i['final_price'],
                i['available'],
                i['enterprise_id'],
                i['percent_discount'],
              );

              if(code == "love"){
                _productItemsLove.add(pitem);
              }
              if(code == "noti"){
                _productItemsNoti.add(pitem);
              }

            }
          });
        }
      } finally {
        client.close();
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(''),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite,color: Colors.grey,)),
                Tab(icon: Icon(Icons.notifications_active,color: Colors.grey)),
              ],
            ),
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () { Navigator.pop(context); },
                        ),
                        InkWell(
                          onTap: () { Navigator.pop(context); },
                          child: Container(
                            padding: const EdgeInsets.only(top: 15,bottom: 15,right: 0,left: 10),
                            child: Text(
                              'بازگشت',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontFamily: 'Yekan'
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )

            ],
          ),
          body: TabBarView(
            children: [
          _result == 1 ? Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height -185,
                  child: _productItemsLove.isNotEmpty ?  Container(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return ProductItem(_productItemsLove[index]);
                      },
                      itemCount: _productItemsLove.length,
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
                ),
              ],
            ) : Loading('در حال بررسی'),
              _result == 1 ? Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height -185,
                    child: _productItemsNoti.isNotEmpty ?  Container(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          return ProductItem(_productItemsNoti[index]);
                        },
                        itemCount: _productItemsNoti.length,
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
                  ),
                ],
              ) : Loading('در حال بررسی'),
            ],
          ),
          bottomNavigationBar: ButtomNavigation(),
        ),
      ),
    );
  }
}
