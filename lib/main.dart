import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:http/http.dart' as http;

import './inc/ButtomNavigation.dart';
import './pages/UpdateApplicationPage.dart';
import './widget/Loading.dart';
import './pages/HomeBody.dart';
import './inc/ApplicationBar.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplash(
      imagePath: 'assets/images/Rosena_ir.png',
      home: Main(),
      duration: 5000,
      type: AnimatedSplashType.StaticDuration,
    ),
  ));
  // runApp(Main());}
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
              EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Image.asset('/assets/images/Rosena_ir.png', width: 250,),
            )
          ],
        )
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var _access_token = new DateTime.now().millisecondsSinceEpoch;
  String _update = 'no';
  @override
  void initState() {
    super.initState();
    _check_update();
  }
  void _check_update() async {
    var client = http.Client();
    try {
      var uriResponse = await client.post('https://www.rosena.ir/api/app/version/controller', headers: {
        'Accept': 'application/json',
      },body: {'version': 3.toString()});
      // print('Response status: ${uriResponse.statusCode}');
      // print('Response body: ${uriResponse.body}');
      if (uriResponse.body.isNotEmpty) {
        if(uriResponse.body == "no"){
          setState(() {
            _update = 'yes';
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UpdateApplicationPage()));
        }else{
           setState(() {
             _update = 'no';
           });
        }
      }
    } finally {
      client.close();
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _update == 'no' ? Scaffold(
        appBar: ApplicationBar(context),
        body: HomeBody(),
        bottomNavigationBar: ButtomNavigation(),
      ) : Loading('درحال بررسی'),
    );
  }
}
