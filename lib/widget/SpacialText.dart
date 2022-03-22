import 'package:flutter/material.dart';
class SpacialText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.pink,
                  height: 35,
                )),
          ),
          Text(
            "فروش ویژه",
            style: TextStyle(
                color: Colors.pink,
                fontFamily: 'Yekan',
                fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Divider(
                  color: Colors.pink,
                  height: 35,
                )),
          ),
        ],
      ),
    );
  }
}
