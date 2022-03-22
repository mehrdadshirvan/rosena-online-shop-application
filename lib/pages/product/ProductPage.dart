import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:core';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:rosena/model/ProductTechnicalSpecificationsModel.dart';
import 'package:rosena/pages/product/ProductTSPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/CategoryModel.dart';
import '../../model/ProductStoreModel.dart';
import '../../widget/Loading.dart';
import '../../model/ProductPageCategories.dart';
import '../../pages/category/CategoryPage.dart';
import 'ProductStorePage.dart';
import '../../model/ProductTechnicalSpecificationsModel.dart';
import '../../inc/ButtomProductNavigationBar.dart';
import '../../model/ProductModel.dart';
import '../../model/ProductResultModel.dart';
import '../shopping/BasketPage.dart';
import '../brand/BrandPage.dart';
import '../../widget/FakeText.dart';
import '../../widget/ProductContent.dart';
import '../auth/LoginPage.dart';
import '../../widget/ProductGridView.dart';
import '../../widget/SpacialText.dart';

class ProductPage extends StatefulWidget {
  ProductResultModel _product;

  ProductPage(this._product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<ProductResultModel> _productLike = [];
  final List<ProductPageModel> _productData = [];
  final List<CategoryModel> _productCategories = [];
  final List<ProductImageGallery> _productGallery = [];
  final List<ProductStoreModel> _productStore = [];
  final List<ProductTechnicalSpecificationsModel> _productTS = [];
  var _check_in_cart = 0;
  var _love_icon = 0;
  var _noti_icon = 0;
  var _access_token, _token_type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getProductInfo();
    _loadTokey();
  }

  void _share(code) async {
    await FlutterShare.share(
      title: 'اشتراک گذاری',
      text: 'https://www.rosena.ir/product/' + code.toString(),
    );
  }

  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _token_type = prefs.getString('token_type');
    });
    _checkProductInCart(widget._product.id, widget._product.enterprise_id);
    _checkUserProductOpt('love', widget._product.id);
    _checkUserProductOpt('noti', widget._product.id);
    _getProductInfo();
  }

  //check product is in cart
  void _checkProductInCart(_product_id, _enterprise_id) async {
    if (_token_type != null && _access_token != null) {
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/app/cart/check', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          'product_id': _product_id.toString(),
          'enterprise_id': _enterprise_id.toString(),
        });
        if (uriResponse.body == 'ok') {
          setState(() {
            _check_in_cart = 1;
          });
        } else {
          setState(() {
            _check_in_cart = 0;
          });
        }
        print(_check_in_cart);
      } finally {
        client.close();
      }
    }
    return;
  }

  //check love or noti for user
  void _checkUserProductOpt(parameter, _product_id) async {
    if (_token_type != null && _access_token != null) {
      // print('connection str');
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/product/opt/check', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          'product_id': _product_id.toString(),
          'position': parameter.toString()
        });

        if (uriResponse.body == "ok") {
          if (parameter == 'love') {
            setState(() {
              _love_icon = 1;
            });
          } else if (parameter == 'noti') {
            setState(() {
              _noti_icon = 1;
            });
          }
        } else if (uriResponse.body == "no") {
          if (parameter == 'love') {
            setState(() {
              _love_icon = 0;
            });
          } else if (parameter == 'noti') {
            setState(() {
              _noti_icon = 0;
            });
          }
        } else {
          print('error');
        }
      } finally {
        client.close();
      }
    } else {
      return;
    }
  }

  void _loveProduct(_product_id) async {
    if (_token_type != null && _access_token != null) {
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/product/opt', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          'product_id': _product_id.toString(),
          'position': 'love'
        });
        // print('Response status: ${uriResponse.statusCode}');
        // print('Response body: ${uriResponse.body}');
        if (uriResponse.body == "add") {
          setState(() {
            _love_icon = 1;
          });
        } else if (uriResponse.body == "delete") {
          setState(() {
            _love_icon = 0;
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

  void _notiProduct(_product_id) async {
    if (_token_type != null && _access_token != null) {
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/product/opt', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          'product_id': _product_id.toString(),
          'position': 'noti'
        });
        // print('Response status: ${uriResponse.statusCode}');
        // print('Response body: ${uriResponse.body}');
        if (uriResponse.body == "add") {
          setState(() {
            _noti_icon = 1;
          });
        } else if (uriResponse.body == "delete") {
          setState(() {
            _noti_icon = 0;
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

  void _getProductInfo() async {
    //print('start connection');
    var url = 'https://www.rosena.ir/api/app/product/?code=' +
        widget._product.rosena_code.toString();
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      var _productInfo = dataJson['product'];
      setState(() {
        var _pinfo = ProductPageModel(
          _productInfo['id'].toString(),
          _productInfo['name'],
          _productInfo['ename'],
          _productInfo['brand_id'].toString(),
          _productInfo['avatar'],
          _productInfo['short_description'],
          _productInfo['content'],
          _productInfo['rosena_code'],
          _productInfo['only_qazvin'],
          _productInfo['stock'],
          _productInfo['fake'],
          _productInfo['video'],
        );
        _productData.add(_pinfo);


        for (var i in _productInfo['gallery']) {
          var _gtitem = ProductImageGallery(
            i['img_url'].toString(),
          );
          _productGallery.add(_gtitem);
        }

        for (var i in _productInfo['categories']) {
          var _catitem = CategoryModel(
              i['category']['id'],
              i['category']['name'].toString(),
              i['category']['ename'].toString(),
              i['category']['ename_url'].toString(),
              i['category']['parent_id'],
              i['category']['img_url_1'].toString(),
              i['category']['get_sub_category'].toString());
          _productCategories.add(_catitem);
        }

        for (var i in dataJson['product_like']) {
          var _pitem = ProductResultModel(
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
          _productLike.add(_pitem);
        }

        for (var i in dataJson['product_filter']) {
          var _item = ProductTechnicalSpecificationsModel(
            i['key'],
            i['value'],
          );
          _productTS.add(_item);
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _addToBasket(_product_id, _enterprise_id) async {
    if (_token_type != null && _access_token != null) {
      setState(() {
        _check_in_cart = 1;
      });
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/app/cart/add', headers: {
          'Accept': 'application/json',
          'Authorization': _token_type + ' ' + _access_token
        }, body: {
          'product_id': _product_id.toString(),
          'enterprise_id': _enterprise_id.toString(),
        });
        // print('Response status: ${uriResponse.statusCode}');
        // print('Response body: ${uriResponse.body}');
        if (uriResponse.body == 'ok') {
          setState(() {
            _check_in_cart = 1;
          });

          Navigator.pop(context, 'ProductStorePage');

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BasketPage()));
        } else {
          // print('error');
        }
      } finally {
        client.close();
      }
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _productData.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              actions: <Widget>[
                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.share),
                                  onPressed: () => _share(
                                      widget._product.rosena_code.toString()),
                                ),
                              ),
                              _noti_icon == 1
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        color: Colors.blue[900],
                                        icon: Icon(Icons.notifications_active),
                                        onPressed: () =>
                                            _notiProduct(widget._product.id),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        color: Colors.grey,
                                        icon: Icon(Icons.notifications_none),
                                        onPressed: () =>
                                            _notiProduct(widget._product.id),
                                      ),
                                    ),
                              _love_icon == 1
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        color: Colors.red,
                                        icon: Icon(Icons.favorite),
                                        onPressed: () =>
                                            _loveProduct(widget._product.id),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        color: Colors.grey,
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: () =>
                                            _loveProduct(widget._product.id),
                                      ),
                                    ),
                              if (_productData[0].video != null)
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    color: Colors.grey,
                                    icon: Icon(Icons.video_library),
                                    onPressed: () {
                                      launch(_productData[0].video.toString());
                                    },
                                  ),
                                ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.shopping_basket),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BasketPage()));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: size.width * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                if (widget._product.price.toString() !=
                                    widget._product.final_price.toString())
                                  SpacialText(),
                                _productGallery.isEmpty
                                    ? Image.network(
                                        'https://www.rosena.ir' +
                                            _productData[0].avatar.toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                      )
                                    : Container(
                                        height: 350,
                                        width: 350,
                                        child: GridView.count(
                                          scrollDirection: Axis.horizontal,
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0,
                                          childAspectRatio: 1 / 1,
                                          dragStartBehavior:
                                              DragStartBehavior.start,
                                          children: List.generate(
                                              _productGallery.length,
                                              (int position) {
                                            return Center(
                                                child: productGalleryItem(
                                                    _productGallery[position],
                                                    context));
                                          }),
                                        ),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: InkWell(
                                        child: Text(
                                          'برند: ' +
                                              widget._product.brand_name
                                                  .toString(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: 'Yekan',
                                              color: Colors.blue[600]),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BrandPage(_productData[0]
                                                          .brand_id
                                                          .toString())));
                                        }),
                                  ),
                                ),
                                Container(
                                  width: size.width * 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      _productData[0].name.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Yekan',
                                        fontSize: 19,
                                        height: 1.5,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6),
                                if (_productData[0].fake.toString() == 'yes')
                                  FakeText(),
                                SizedBox(height: 6),
                              ],
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  if (_productCategories.isNotEmpty)
                    Container(
                      height: 50,
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 1,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1 / 4,
                        dragStartBehavior: DragStartBehavior.start,
                        children: List.generate(_productCategories.length,
                            (int position) {
                          return Center(
                              child: productCategoryItem(
                                  _productCategories[position], context));
                        }),
                      ),
                    ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductTSPage(_productTS)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      width: size.width,
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Yekan',
                            fontSize: 20,
                            color: Colors.grey[800],
                          ),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 0, left: 15),
                                child: Icon(Icons.settings,
                                    color: Colors.grey[800]),
                              ),
                            ),
                            TextSpan(
                              text: 'مشخصات فنی',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  if (widget._product.final_price.toString() != '0' &&
                      widget._product.final_price.toString() != '' &&
                      widget._product.final_price.toString() != null)
                    InkWell(
                      onTap: () {
                        return Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductStorePage(
                                widget._product.rosena_code.toString(),
                                _addToBasket)));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 20),
                        width: size.width,
                        // height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 20,
                              color: Colors.grey[800],
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 0, left: 15),
                                  child: Icon(Icons.store_mall_directory,
                                      color: Colors.grey[800]),
                                ),
                              ),
                              TextSpan(
                                text: 'فروشندگان این محصول',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 1),
                  if (_productData[0].content != null)
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Container(
                          width: size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductContent(
                                          _productData[0].content)));
                                },
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                textColor: Colors.white,
                                color: Colors.blue[600],
                                hoverColor: Colors.blue[800],
                                child: Text(
                                  'نمایش نقد و بررسی محصول',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Yekan'),
                                ),
                              )),
                        )
                      ],
                    ),
                  SizedBox(height: 6),
                  if (_productLike.isNotEmpty)
                    Container(
                      height: 400,
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: RichText(
                                textDirection: TextDirection.rtl,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Yekan',
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, left: 15),
                                        child: Icon(Icons.bookmark,
                                            color: Colors.grey[800]),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'محصولات مشابه',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 300,
                              padding: EdgeInsets.all(0),
                              child: GridView.count(
                                crossAxisCount: 1,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 2,
                                childAspectRatio: 3 / 1.9,
                                dragStartBehavior: DragStartBehavior.start,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(_productLike.length,
                                    (int position) {
                                  return ProductGridView(
                                      _productLike[position]);
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: size.width * 1,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'شناسه کالا: ' +
                              _productData[0].rosena_code.toString(),
                          style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 15,
                              color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ButtomProductNavigationBar(
                _addToBasket,
                widget._product.id.toString(),
                widget._product.enterprise_id.toString(),
                widget._product.price,
                widget._product.final_price,
                _check_in_cart.toString()))
        : Scaffold(
            appBar: null,
            body: Container(width: size.width, child: Loading('')),
            backgroundColor: Colors.white,
          );
  }
}

Card productCategoryItem(CategoryModel category, context) {
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
                    color: Colors.grey.shade800,
                    fontFamily: 'Yekan',
                    fontSize: 12,
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

Card productGalleryItem(ProductImageGallery gallery, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    elevation: 0,
    child: InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => CategoryPage(gallery.ename_url)));
      },
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.all(5),
              child: Center(
                child: Image.network(
                  'https://www.rosena.ir' + gallery.image_url.toString(),
                  width: 340,
                  height: 340,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ProductImageGallery {
  final String _image_url;

  ProductImageGallery(this._image_url);

  String get image_url => _image_url;
}
