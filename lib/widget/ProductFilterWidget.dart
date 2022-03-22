import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/BrandListByCategoryModel.dart';

class ProductFilterWidget extends StatefulWidget {
  final Function _listFilter;
  final String _category;

  ProductFilterWidget(this._listFilter, this._category);

  @override
  _ProductFilterWidgetState createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  final List<BrandListByCategoryModel> _brandList = [];
  bool _checkMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBrandList();
  }

  void _getBrandList() async {
    var url = 'https://www.rosena.ir/api/app/category/brand/' +
        widget._category.toString();
    Response response = await get(url);
    setState(() {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in dataJson) {
        var _bitem = BrandListByCategoryModel(
          i['id'].toString(),
          i['name'],
          i['ename'],
          i['img_url'],
        );
        _brandList.add(_bitem);
      }
    });
  }

  void _checkMeFunction(brand_id,value) {
    print(brand_id);
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return new CheckboxListTile(
            title: Text(_brandList[index].name.toString()),
            value: _checkMe,
            onChanged: (_) => _checkMeFunction(_brandList[index].id.toString(),_),
          );
        },
      ),
    );
  }
}
