import 'package:flutter/material.dart';

class ApplicationBarUserProfile extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext context;
  final Function _logout;

  ApplicationBarUserProfile(this.context, this._logout);

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
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 15,right: 0,left: 10),
                          child: Text(
                            'بازگشت',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontFamily: 'Yekan'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          onTap: () => _logout(),
                          child: Text(
                            'خروج از حساب کاربری',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle_outline,
                              color: Colors.grey),
                          onPressed: () => _logout(),
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
