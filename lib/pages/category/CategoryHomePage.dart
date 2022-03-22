import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../model/CategoryModel.dart';
import 'CategoryPage.dart';
import '../../widget/Loading.dart';

class CategoryHomePage extends StatefulWidget {
  @override
  _CategoryHomePageState createState() => _CategoryHomePageState();
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  final List<CategoryModel> _items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItems();
  }

  void _getItems() async {
    var url = 'https://www.rosena.ir/api/app/category';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(context),
      body: SingleChildScrollView(
        child: _items.length > 0 ? Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 140,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                dragStartBehavior: DragStartBehavior.down,
                scrollDirection: Axis.vertical,
                children: List.generate(_items.length, (int position) {
                  return generateItem(_items[position], context);
                }),
              ),
            ),
          ],
        ) : Loading('درحال دریافت اطلاعات'),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}

Card generateItem(CategoryModel category, context) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    elevation: 2,
    child: InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=> CategoryPage(category.ename_url)
        ));
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              child: Image.network(
                'https://www.rosena.ir' + category.img_url_1.toString(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(13),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0,bottom: 1.0),
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Yekan',
                      fontSize: 13,
                    ),
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
