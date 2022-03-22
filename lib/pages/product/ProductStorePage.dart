import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../inc/ApplicationBarJustBackBtn.dart';
import '../../model/ProductStoreModel.dart';
import '../../widget/Loading.dart';
import '../../widget/ProductStoreItem.dart';

class ProductStorePage extends StatefulWidget {
  final String _rosena_code;
  final Function _addToBasket;
  ProductStorePage(this._rosena_code,this._addToBasket);

  @override
  _ProductStorePageState createState() => _ProductStorePageState();
}

class _ProductStorePageState extends State<ProductStorePage> {
  final List<ProductStoreModel> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData(widget._rosena_code.toString());
  }

  void _loadData(code) async {
    print('ss');
    var url = 'https://www.rosena.ir/api/app/product/store/' + code.toString();
    Response response = await get(url);
    setState(() {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in dataJson) {
        print(dataJson);
        var _item = ProductStoreModel(
          i['product_id'],
          i['enterprise_id'],
          i['name'],
          i['ename'],
          i['send_time'],
          i['avatar'],
          i['garanti'],
          i['available'],
          i['price'],
          i['final_price'],
          i['discount_percent'],
        );
        _items.add(_item);
      }
    });
    print(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SingleChildScrollView(
        child: _items.isNotEmpty
            ? Container(
          height: MediaQuery.of(context).size.height - 50,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 50),
          child: ListView.builder(
            padding: EdgeInsets.all(15),
            itemBuilder: (ctx, index) {
              return ProductStoreItem(_items[index],widget._addToBasket);
            },
            itemCount: _items.length,
          ),
        ) : Loading('در حال دریافت!'),
      ),
    );
  }
}
