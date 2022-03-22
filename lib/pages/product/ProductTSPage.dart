import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../inc/ApplicationBarJustBackBtn.dart';
import '../../model/ProductTechnicalSpecificationsModel.dart';
import '../../widget/Loading.dart';
import '../../widget/ProductTS.dart';

class ProductTSPage extends StatelessWidget {
  List<ProductTechnicalSpecificationsModel> _productTSList;
  ProductTSPage(this._productTSList);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: Container(
        child: SingleChildScrollView(
          child: _productTSList.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemBuilder: (ctx, index) {
                      return ProductTS(_productTSList[index]);
                    },
                    itemCount: _productTSList.length,
                  ),
                )
              : Loading('در حال دریافت!'),
        ),
      ),
    );
  }
}
