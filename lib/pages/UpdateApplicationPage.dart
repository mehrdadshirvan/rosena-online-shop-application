import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Text(
          'به روز رسانی',
          style: TextStyle(
            color: Colors.pink,
            fontFamily: 'Yekan',
            fontSize: 20
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height ,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Image.asset('assets/images/Rosena_ir.png', width: 350),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 75,
                  child: Text(
                    'فروشگاه اینترنتی رزنا',
                    style: TextStyle(
                      height: 1.5,
                      fontFamily: "Yekan",
                      fontSize: 25,
                      color: Colors.pink,
                    ),
                  ),
                ),
                Text(
                  'دانلود جدیدترین ورژن اپلیکیشن رزنا',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Yekan',
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 25,),
                Text(
                  'برای دریافت آخرین ورژن اپلیکیشن روی دکمه دانلود کلیک کنید',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Yekan',
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 25,),
                RaisedButton(
                  onPressed: (){
                    launch('https://www.rosena.ir/rosena.apk');
                  },
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(top: 15,bottom: 15,right: 30,left: 30),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Yekan',
                      ),
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.file_download),
                        ),
                        TextSpan(
                          text: 'دریافت فایل',
                        ),
                      ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
