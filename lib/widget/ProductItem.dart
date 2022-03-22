import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/ProductResultModel.dart';
import '../pages/product/ProductPage.dart';
import '../widget/SpacialText.dart';
import '../model/ProductModel.dart';

class ProductItem extends StatelessWidget {
  final ProductResultModel _product;

  ProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductPage(_product)));
        },
        child: Column(
          children: <Widget>[
            if (_product.price.toString() != _product.final_price.toString())
              SpacialText(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    textDirection: TextDirection.rtl,
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _product.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: 'Yekan',
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (_product.final_price.toString() == '0')
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'ناموجود',
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (_product.final_price.toString() != '0' &&
                          _product.price.toString() !=
                              _product.final_price.toString())
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Vazir',
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: '${_product.price.toString()}' +
                                      ' ' +
                                      'تومان',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    fontFamily: 'Vazir',
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(text: ' '),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.all(4.5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    height: 25,
                                    child: Text(
                                      _product.percent_discount.toString() +  "%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Vazir',
                                        fontSize: 12,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_product.final_price.toString() != '0')
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${_product.final_price.toString()}' +
                                ' ' +
                                'تومان',
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'Vazir',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.network(
                      'https://www.rosena.ir' + _product.avatar.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
