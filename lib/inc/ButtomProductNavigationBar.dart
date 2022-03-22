import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtomProductNavigationBar extends StatelessWidget {
  final Function addToBasket;
  final String price;
  final String final_price;
  final String product_id;
  final String enterprise_id;
  final String _check_in_cart;

  ButtomProductNavigationBar(
    @required this.addToBasket,
    @required this.product_id,
    @required this.enterprise_id,
    @required this.price,
    @required this.final_price,
    @required this._check_in_cart,
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            if (final_price != '0' && final_price != '' && final_price != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _check_in_cart == '0' ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: RaisedButton(
                      onPressed: () => addToBasket(product_id, enterprise_id),
                      textColor: Colors.white,
                      color: Colors.pink.shade500,
                      child: Text(
                        'افزودن به سبد خرید',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Yekan'
                        ),
                      ),
                    ),
                  ) : Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      'در سبد خرید شما موجود میباشد',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Yekan'
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (final_price != '0' && final_price != '' && final_price != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      textDirection: TextDirection.rtl,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (final_price != price)
                          Text(
                            price.toString() + ' تومان',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: 'Vazir',
                                fontSize: 13,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red),
                          ),
                        Text(
                          final_price.toString() + ' تومان',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: 'Vazir', fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (final_price == '0' || final_price == '' || final_price == null)
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'ناموجود',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5,
                            fontSize: 25,
                            color: Colors.red,
                            fontFamily: 'Yekan',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
