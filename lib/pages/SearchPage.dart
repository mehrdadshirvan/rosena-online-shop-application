import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../inc/ApplicationBar.dart';
import '../inc/ButtomNavigation.dart';
import '../model/ProductResultModel.dart';
import '../widget/Loading.dart';
import '../widget/ProductItem.dart';

class SearchPage extends StatefulWidget {
  final _enteredSearch;

  SearchPage(this._enteredSearch);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<ProductResultModel> _productItems = [];
  ScrollController _scrollController = ScrollController();
  int _currenMax = 1;
  String _loadMore = "";
  var _pageResult;
  var _result = 0;

  void _getProduct(page) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(
          'https://www.rosena.ir/api/search/?search=' +
              widget._enteredSearch.toString() +
              '&&page=' +
              page,
          headers: {'Accept': 'application/json'});
      print(uriResponse.body);
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
            _productItems.add(pitem);
          }
          _loadMore = "";
        });
        setState(() {
          _result = 1;
        });
      } else {
        print('error');
      }
    } finally {
      client.close();
    }
  }

  _getTen() {
    for (int i = _currenMax; i < _currenMax + 1; i++) {
      _getProduct(i.toString());
    }
    setState(() {
      _currenMax = _currenMax + 1;
      _loadMore = "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTen();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getTen();
        setState(() {
          _loadMore = "درحال دریافت ...";
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(context),
      body: SingleChildScrollView(
        child: _result == 1
            ? Container(
                child: _productItems.isNotEmpty
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 175,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemBuilder: (ctx, index) {
                                  return ProductItem(_productItems[index]);
                                },
                                itemCount: _productItems.length,
                              ),
                            ),
                            if (_loadMore != null)
                              Container(
                                padding: EdgeInsets.only(top: 1, bottom: 1),
                                child: Text(
                                  _loadMore.toString(),
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Yekan',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(25),
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
              )
            : Loading('درحال دریافت'),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}
