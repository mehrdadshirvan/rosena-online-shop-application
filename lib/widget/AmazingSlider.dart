import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widget/ProductGridView.dart';
import '../model/ProductResultModel.dart';

class AmazingSlider extends StatelessWidget {
  List<ProductResultModel> _amazingSliderProduct = [];

  AmazingSlider(this._amazingSliderProduct);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return _amazingSliderProduct.isNotEmpty
        ? Container(
            height: 340,
            color: Colors.pink[100],
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 310,
                    padding: EdgeInsets.all(0),
                    child: GridView.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 3/1.9,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(_amazingSliderProduct.length, (int position) {
                        return ProductGridView(_amazingSliderProduct[position]);
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
