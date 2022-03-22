import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:rosena/widget/ProductSortWidget.dart';
import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../model/BrandModel.dart';
import '../../model/ProductResultModel.dart';
import '../../widget/Loading.dart';
import '../../widget/ProductItem.dart';

class BrandPage extends StatefulWidget {
  final String _brand_id;

  BrandPage(this._brand_id);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  final List<ProductResultModel> _productItems = [];
  ScrollController _scrollController = ScrollController();
  int _currentMax = 1;
  String _loadMore = "";
  String _sort = "popularity";
  String _sortText = "محبوب ترین";

  void getProduct(page) async {
    var url = 'https://www.rosena.ir/api/brand/' +
        widget._brand_id +
        '/product/?page=' +
        page;
    Response response = await get(url);
    setState(() {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));
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
  }

  _getTen() {
    for (int i = _currentMax; i < _currentMax + 1; i++) {
      getProduct(i.toString());
    }
    setState(() {
      _currentMax = _currentMax + 1;
      _loadMore = "";
    });
  }

  void _startAddNewSort(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          child: ProductSortWidget(_listFilter),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _listFilter(Sort_para){
    setState(() {
      _productItems.clear();
      _sort = "&sort=" + Sort_para.toString();
      _currentMax = 1;
      if(Sort_para == "inexpensive"){
        _sortText = "ارزان ترین";
      }else if(Sort_para == "expensive"){
        _sortText = "گران ترین";
      }else if(Sort_para == "newest"){
        _sortText = "جدید ترین";
      }else if(Sort_para == "popularity"){
        _sortText = "محبوب ترین";
      }else if(Sort_para == "sell"){
        _sortText = "پرفروش ترین";
      }

    });
    _getTen();
    Navigator.of(context).pop();
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
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height - 180,
            color: Colors.white,
            child: _productItems.isEmpty ? Loading('در حال دریافت') : Column(
              children: <Widget>[
                if (_productItems.isNotEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height - 220,
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
                    padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 100,
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _startAddNewSort(context),
                      child: Container(
                          width: 150,
                          padding: EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 10),
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Yekan',
                                  color: Colors.grey.shade700,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.sort,
                                      size: 20,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " " + _sortText.toString(),
                                  )
                                ]),
                          )),
                    ),
                  ],
                ),
              ),
              ButtomNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}
