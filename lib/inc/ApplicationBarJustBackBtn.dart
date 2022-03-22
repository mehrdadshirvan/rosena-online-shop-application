import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ApplicationBarJustBackBtn extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  ApplicationBarJustBackBtn(this.context);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text(''),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
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
                    onPressed: () { Navigator.pop(context); },
                  ),
                  InkWell(
                    onTap: () { Navigator.pop(context); },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15,bottom: 15,right: 0,left: 10),
                      child: Text(
                          'بازگشت',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'Yekan'
                        ),
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        )

      ],
    );
  }
}
