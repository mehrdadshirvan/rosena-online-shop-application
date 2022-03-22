import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widget/ProductGridView.dart';
import '../model/ProductResultModel.dart';

class ProductGridViewByCategory extends StatelessWidget {
  List<ProductResultModel> _product = [];

  ProductGridViewByCategory(this._product);

  @override
  Widget build(BuildContext context) {
    return _product.isNotEmpty
        ? Container(
      height: 390,
            color: Colors.white,
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 310,
                    padding: EdgeInsets.all(0),
                    child: GridView.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 2,
                      childAspectRatio: 3/1.9,
                      dragStartBehavior: DragStartBehavior.down,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(_product.length, (int position) {
                        return ProductGridView(_product[position]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
