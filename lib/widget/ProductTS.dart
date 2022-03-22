import 'package:flutter/material.dart';
import '../model/ProductTechnicalSpecificationsModel.dart';

class ProductTS extends StatelessWidget {
  final ProductTechnicalSpecificationsModel _ts;

  ProductTS(this._ts);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _ts.key,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  _ts.value,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Yekan',
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 6,color: Colors.grey[300],)
        ],
      ),
    );
  }
}
