import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import '../../model/BrandListByCategoryModel.dart';
import '../../widget/ProductFilterWidget.dart';
import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../model/ProductResultModel.dart';
import '../../widget/Loading.dart';
import '../../widget/ProductItem.dart';
import '../../widget/ProductSortWidget.dart';
import '../../model/ProductModel.dart';
import '../../model/CategoryModel.dart';

import '../../widget/ProductItem.dart';

class CategoryPage extends StatefulWidget {
  final String _category;

  CategoryPage(this._category);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<CategoryModel> _items = [];
  final List<ProductResultModel> _productItems = [];
  ScrollController _scrollController = ScrollController();
  int _currentMax = 1;
  String _loadMore = "";
  String _sort = "popularity";
  String _sortText = "محبوب ترین";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
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


  void getItems() async {
    var url =
        'https://www.rosena.ir/api/app/category/' + widget._category.toString();
    Response response = await get(url);
    setState(() {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in dataJson) {
        var _item = CategoryModel(
          i['id'],
          i['name'],
          i['ename'],
          i['ename_url'],
          i['parent_id'],
          i['img_url_1'],
          i['get_sub_category'],
        );
        _items.add(_item);
      }
    });
  }

  _getTen() {
    for (int i = _currentMax; i < _currentMax + 1; i++) {
      getProduct(i.toString(),_sort);
    }
    setState(() {
      _currentMax = _currentMax + 1;
      _loadMore = "";
    });
  }

  void getProduct(page,sort) async {
    var url = 'https://www.rosena.ir/api/app/category/' +
        widget._category.toString() +
        '/product/?page=' + page.toString() + sort.toString() ;
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

  void _startAddNewFilter(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          child: ProductFilterWidget(_listFilter,widget._category.toString()),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(context),
        body: SingleChildScrollView(
          child: _productItems.isNotEmpty
              ? Container(
                  child: Column(
                    children: <Widget>[
                      if (_items.isNotEmpty)
                        Container(
                          height: 80,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 1,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 5,
                            childAspectRatio: 2 / 3,
                            dragStartBehavior: DragStartBehavior.start,
                            children:
                                List.generate(_items.length, (int position) {
                              return Center(
                                  child:
                                      generateItem(_items[position], context));
                            }),
                          ),
                        ),
                      if (_items.isNotEmpty)
                        Container(
                          height: MediaQuery.of(context).size.height - 285,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemBuilder: (ctx, index) {
                              return ProductItem(_productItems[index]);
                            },
                            itemCount: _productItems.length,
                          ),
                        ),
                      if (_items.isEmpty)
                        Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 205,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemBuilder: (ctx, index) {
                                  return ProductItem(_productItems[index]);
                                },
                                itemCount: _productItems.length,
                              ),
                            ),
                          ],
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
              : Loading('در حال دریافت'),
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

Card generateItem(CategoryModel category, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    elevation: 4,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryPage(category.ename_url)));
      },
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Yekan',
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
