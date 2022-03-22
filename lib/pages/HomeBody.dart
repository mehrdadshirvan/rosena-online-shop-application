import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rosena/model/CategoryModel.dart';
import 'package:rosena/model/ProductResultModel.dart';
import 'package:rosena/widget/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/HomeSliderModel.dart';
import '../pages/AboutUsPage.dart';
import '../widget/AmazingSlider.dart';
import '../widget/HomeCategory.dart';
import '../widget/ProductGridViewByCategory.dart';
import '../widget/HomeSliders.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<HomeSliderModel> _sliderList = [];
  final List<CategoryModel> _categoryList = [];
  final List<ProductResultModel> _amazingSliderProduct = [];
  final List<ProductResultModel> _catSliderProduct0 = [];
  final List<ProductResultModel> _catSliderProduct1 = [];
  final List<ProductResultModel> _catSliderProduct2 = [];
  final List<ProductResultModel> _catSliderProduct3 = [];
  final List<ProductResultModel> _catSliderProduct4 = [];
  final List<ProductResultModel> _catSliderProduct5 = [];
  var _token_type;
  var _numItem=0;
  var _result = 0;
  @override
  void initState() {
    super.initState();
    _loadTokey();
    _getHomeParameter();
  }

  //Loading counter value on start
  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token_type = prefs.getString('access_token');
    });
  }

  void _getHomeParameter() async {
    // print('start');
    var url = 'https://www.rosena.ir/api/app/homepage';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);

      setState(() {
        for (var i in dataJson['slider']) {
          var sliderItem = HomeSliderModel(
            i['title'],
            i['img_url'],
            i['link_to'],
            i['category'],
            i['brand'],
          );
          _sliderList.add(sliderItem);
        }

        for (var i in dataJson['categories']) {
          var _catitem = CategoryModel(
            i['id'],
            i['name'],
            i['ename'],
            i['ename_url'],
            i['parent_id'],
            i['img_url_1'],
            i['get_sub_category'],
          );
          _categoryList.add(_catitem);
        }

        for (var i in dataJson['amazing_slider']) {
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
          _amazingSliderProduct.add(_pitem);
        }

        for (var v in dataJson['cat_slider']) {
          _numItem += v.length;
          for(var j in v){
            var _pitem = ProductResultModel(
              j['id'],
              j['name'],
              j['name_url'],
              j['ename'],
              j['brand_id'],
              j['brand_name'],
              j['brand_ename_url'],
              j['special'],
              j['avatar'],
              j['rosena_code'],
              j['stock'],
              j['fake'],
              j['price'],
              j['final_price'],
              j['available'],
              j['enterprise_id'],
              j['percent_discount'],
            );
            if(_numItem <= 12){
              _catSliderProduct0.add(_pitem);
            }else if(_numItem <= 24){
              _catSliderProduct1.add(_pitem);
            }else if(_numItem <= 36){
              _catSliderProduct2.add(_pitem);
            }else if(_numItem <= 48){
              _catSliderProduct3.add(_pitem);
            }else if(_numItem <= 60){
              _catSliderProduct4.add(_pitem);
            }else if(_numItem <= 72){
              _catSliderProduct5.add(_pitem);
            }
          }
        }

        _result = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: _result == 1 ? Container(
          child: Column(
            children: <Widget>[
              if(_sliderList.isNotEmpty) Container(
                child: HomeSliders(_sliderList),
              ),
              if(_categoryList.isNotEmpty) Container(
                child: HomeCategory(_categoryList),
              ),
              if(_amazingSliderProduct.isNotEmpty) Container(
                child: AmazingSlider(_amazingSliderProduct),
              ),
              if(_catSliderProduct0.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct0),
              ),
              if(_catSliderProduct1.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct1),
              ),
              if(_catSliderProduct2.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct2),
              ),
              if(_catSliderProduct3.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct3),
              ),
              if(_catSliderProduct4.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct4),
              ),
              if(_catSliderProduct5.isNotEmpty) Container(
                child: ProductGridViewByCategory(_catSliderProduct5),
              ),
              SizedBox(
                height: 25,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Rosena Application v 0.0.2',
                          style: TextStyle(fontFamily: 'Yekan', fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AboutUsPage()));
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.pink,
                                    fontFamily: 'Yekan'),
                                children: [
                                  TextSpan(
                                    text: 'درباره ما',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ) : Loading(''),
      ),
    );
  }
}
