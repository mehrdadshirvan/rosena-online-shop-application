import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';
import 'package:url_launcher/url_launcher.dart';
import '../inc/ApplicationBarJustBackBtn.dart';
import '../model/ProductResultModel.dart';

class ProductContent extends StatelessWidget {
  var _product;

  ProductContent(this._product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Html(
                  customTextAlign: (_) => TextAlign.right,
                  useRichText: true,
                  shrinkToFit: true,
                  customTextStyle: ( _ , TextStyle baseStyle) {
                    return baseStyle.merge(
                        TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                        ));
                  },
                  data: _product,
                  defaultTextStyle: TextStyle(
                    fontFamily: 'Yekan',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                  linkStyle: TextStyle(
                    color: Colors.blueAccent,
                  ),
                  padding: EdgeInsets.all(10),
                  onLinkTap: (url) {
                    launch(url);
                  },
                  onImageTap: (src) {
                    launch(src);
                  },
                  imageProperties: ImageProperties(
                      width: MediaQuery.of(context).size.width / 2,
                      repeat: ImageRepeat.noRepeat,
                      fit: BoxFit.fitWidth),
                  showImages: true,
                ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
