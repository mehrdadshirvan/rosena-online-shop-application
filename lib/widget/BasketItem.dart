import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/BasketModel.dart';
class BasketItem extends StatelessWidget {
  final BasketModel _cart;
  final Function _deleteCart;
  final Function _updateCartItem;
  final String _number_value;

  BasketItem(
      this._cart, this._deleteCart, this._updateCartItem, this._number_value);


  @override
  Widget build(BuildContext context) {
    final List _avl = [];
    for(var i = 1;i <= _cart.available ;i++){
      _avl.add(i.toString());
    }
    return Card(
      elevation: 0.5,
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Image.network(
                'https://www.rosena.ir' + _cart.avatar.toString()),
          ),
          Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    _cart.product_name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontFamily: 'Yekan',
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.pink,
                              fontFamily: 'Yekan',
                              fontSize: 12),
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.store,color: Colors.pink,size: 18,),
                            ),
                            TextSpan(
                              text: _cart.enterprise_name.toString(),
                            ),
                          ]),
                    )),
                SizedBox(
                  height: 1,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Yekan',
                              fontSize: 12),
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.check_circle,color: Colors.grey,size: 18,),
                            ),
                            TextSpan(
                              text: 'گارانتی اصالت و سلامت فیزیکی کالا',
                            ),
                          ]),
                    )),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تعداد: ',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontFamily: 'Yekan',
                      height: 1.5,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      items: _avl.map((value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      value: _cart.number_order.toString(),
                      icon: Icon(Icons.expand_more),
                      onChanged: (_) {
                        _updateCartItem(_cart.id, _cart.product_id, _);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'قیمت کل: ' + _cart.final_price.toString() + ' ' + 'تومان',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'حذف از سبد خرید',
                    style: TextStyle(fontFamily: 'Yekan', fontSize: 16),
                  ),
                  color: Colors.red.shade200,
                  textColor: Colors.white,
                  onPressed: () => _deleteCart(_cart.id),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
