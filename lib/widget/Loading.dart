import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String _text;

  Loading(this._text);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   child: Text(
          //     _text.toString(),
          //     style: TextStyle(
          //       color: Colors.grey[800],
          //       fontFamily: 'Yekan',
          //       fontSize: 25,
          //     ),
          //     textDirection: TextDirection.rtl,
          //   ),
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/loading4.gif'),
            ],
          ),
        ],
      ),
    );
  }
}
