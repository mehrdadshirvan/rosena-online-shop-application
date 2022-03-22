import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../inc/ApplicationBarJustBackBtn.dart';
class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.center,
                height: 25,
                child: InkWell(
                  onTap: (){
                    launch('https://www.rosena.ir');
                  },
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0, left: 30),
                              child: Icon(Icons.laptop_windows),
                            ),
                          ),
                          TextSpan(
                              text: 'www.rosena.ir',
                              style: TextStyle(fontFamily: 'Yekan', fontSize: 20,color: Colors.grey,))
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.center,
                height: 25,
                child: RichText(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0, left: 30),
                            child: Icon(Icons.alternate_email),
                          ),
                        ),
                        TextSpan(
                            text: 'info@rosena.ir',
                            style: TextStyle(fontFamily: 'Yekan', fontSize: 20,color: Colors.grey,))
                      ]),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            launch('https://instagram.com/rosena_ir');
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/icon/instagram.png', width: 40),
                              SizedBox(height: 6,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            launch('https://wa.me/message/GVEE4QKCY7SUO1');
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/icon/whatsapp.png', width: 40),
                              SizedBox(height: 6,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            launch('https://www.aparat.com/rosenair');
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/icon/aparat-logo-png-transparent.png', width: 40),
                              SizedBox(height: 6,),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            launch('https://www.rosena.ir');
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/icon/enamad.png', width: 90),
                              SizedBox(height: 6,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 6,),
                        Text(
                          'Rosena Application v 0.0.2',
                          style: TextStyle(fontFamily: 'Yekan', fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:  25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
