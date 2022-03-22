import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../model/CategoryModel.dart';
import '../pages/category/CategoryPage.dart';

class HomeCategory extends StatelessWidget {
  List<CategoryModel> _categoryList;
  HomeCategory(this._categoryList);

  @override
  Widget build(BuildContext context) {
    return _categoryList.isNotEmpty ? Container(
      height: 150,
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 5,
        childAspectRatio: 2/1.9,
        dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.horizontal,
        children: List.generate(_categoryList.length, (int position) {
          return generateItem(_categoryList[position], context);
        }),
      ),
    ) : Container();
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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
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
                    category.name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Yekan',
                      fontSize: 14,
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
