import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ApplicationBarProductPage extends StatelessWidget
    implements PreferredSizeWidget {
  final String _product_id;
  var _Love_icon;
  final Function _loveProduct;
  final Function _notiProduct;

  ApplicationBarProductPage(
      this._loveProduct, this._notiProduct, this._product_id, this._Love_icon);

  var checkLove = 0;
  var checkNoti = 0;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      actions: <Widget>[
        Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.notifications_none),
                          onPressed: () => _notiProduct(_product_id),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: Colors.grey,
                          icon: _Love_icon,
                          onPressed: () => _loveProduct(_product_id),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: Colors.grey,
                          icon: Icon(Icons.shopping_basket),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
