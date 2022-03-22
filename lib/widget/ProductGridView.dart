import 'package:flutter/material.dart';
import '../model/ProductResultModel.dart';
import '../pages/product/ProductPage.dart';

class ProductGridView extends StatelessWidget {
  final ProductResultModel _product;
  ProductGridView(this._product);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:  Alignment.centerLeft,
      child: SizedBox(
        width: 200,//MediaQuery.of(context).size.width / 2.5, //you sure it should be 0.001?
        height: MediaQuery.of(context).size.height,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProductPage(_product)));
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // height: 140,
                    // width: MediaQuery.of(context).size.width / 1.3,
                    width: 140,
                    child: Image.network(
                      'https://www.rosena.ir' + _product.avatar.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                        child: Container(
                          height: 50,
                          child: Text(
                            _product.name.toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Yekan',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  if(_product.price != _product.final_price) Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15,right: 15),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text(
                      _product.final_price.toString() + ' تومان',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
