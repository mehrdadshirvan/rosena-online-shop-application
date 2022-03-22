import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/ProductStoreModel.dart';

class ProductStoreItem extends StatelessWidget {
  final ProductStoreModel _store;
  final Function _addToBasket;

  ProductStoreItem(this._store, this._addToBasket);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  'https://www.rosena.ir' + _store.avatar.toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                textDirection: TextDirection.rtl,
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Yekan',
                        fontSize: 17,
                        height: 1.5,
                      ),
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.store,
                            color: Colors.pink,
                          ),
                        )),
                        TextSpan(
                          text: _store.name.toString(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Yekan',
                        fontSize: 14,
                        wordSpacing: 2,
                        height: 1.5,
                      ),
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.security,
                            color: Colors.blue[900],
                          ),
                        )),
                        TextSpan(
                          text: _store.garanti.toString(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Yekan',
                        fontSize: 14,
                        height: 1.5,
                      ),
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.local_shipping,
                            color: Colors.deepPurple,
                          ),
                        )),
                        TextSpan(
                          text: _store.send_time.toString(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if (_store.price != _store.final_price)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 15, right: 15),
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
                              text:
                                  '${_store.price.toString()}' + ' ' + 'تومان',
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
                                  _store.discount_percent.toString() + "%",
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
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      _store.final_price.toString() + ' تومان',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _addToBasket(
                            _store.product_id, _store.enterprise_id),
                        textColor: Colors.white,
                        color: Colors.pink,
                        child: Text(
                          'افزودن به سبد خرید',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Yekan'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
