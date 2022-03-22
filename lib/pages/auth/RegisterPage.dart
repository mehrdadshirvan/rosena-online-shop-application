import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../main.dart';
import '../../model/ErrorMessageModel.dart';
import '../../model/GetTokenModel.dart';
import '../../pages/auth/LoginPage.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMsg = '';
  String _token_type;
  String _expires_in;
  String _access_token;
  String _refresh_token;
  var _error_message;

  @override
  void initState() {
    super.initState();
    // _loadTokey();
  }

  //Loading counter value on start
  _loadTokey(keyName, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(keyName, value);
    });
  }

  void _submitData() async {
    final _enteredMobile = _mobileController.text.toString();
    final _enteredPassword = _passwordController.text.toString();
    _errorMsg = '';
    if (_mobileController.text.isEmpty) {
      setState(() {
        _errorMsg = 'شماره موبایل خود را وارد کنید';
      });
      return;
    }
    if (_enteredPassword.length <= 5 || _enteredPassword.isEmpty) {
      setState(() {
        _errorMsg = 'رمز ورود نامعتبر است';
      });
      return;
    }

    var client = http.Client();
    // print('start connection');
    setState(() {
      _errorMsg = 'درحال بررسی اطلاعات';
    });
    try {
      var uriResponse =
          await client.post('https://www.rosena.ir/api/register', headers: {
        'Accept': 'application/json'
      }, body: {
        'username': _enteredMobile.toString(),
        'password': _enteredPassword.toString(),
      });
      // print('Response status: ${uriResponse.statusCode}');
      // print('Response body: ${uriResponse.body}');
      if (uriResponse.body.isNotEmpty) {
        var response = uriResponse.body;
        var dataJson = json.decode(response);

        var _error_message = ErrorMessge(
          dataJson['error'].toString(),
          dataJson['errors'].toString(),
          dataJson['error_description'],
          dataJson['message'],
        );
        var _tt = TokenGet(
          dataJson['token_type'],
          dataJson['expires_in'],
          dataJson['access_token'],
          dataJson['refresh_token'],
        );

        _token_type = _tt.token_type;
        _expires_in = _tt.expires_in.toString();
        _access_token = _tt.access_token;
        _refresh_token = _tt.refresh_token;

        // var _new_js_decode = json.encode(_error_message.error.indexOf('username'));
        // print('11');
        // print(json.decode(_new_js_decode).toString());
        // print(_new_js_decode);
        // print('00');
        setState(() {
          if (_error_message.message == "The given data was invalid.") {
            _errorMsg =
                "شما قبلا ثبت نام کرده اید و یا شماره خود را به درستی وارد نکردید";
          }
        });
        if (_token_type.isNotEmpty ||
            _access_token.isNotEmpty ||
            _refresh_token.isNotEmpty) {
          _loadTokey('token_type', _token_type.toString());
          _loadTokey('refresh_token', _refresh_token.toString());
          _loadTokey('access_token', _access_token.toString());

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Main(),
            ),
          );
        }
        if (_token_type.isEmpty ||
            _access_token.isEmpty ||
            _refresh_token.isEmpty) {
          setState(() {
            _errorMsg = 'کاربر وجود دارد! مجددا اطلاعات صحیح را وارد کنید';
          });
        } else {
          setState(() {
            _errorMsg = '';
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Main(),
            ),
          );
        }
      } else {
        setState(() {
          _errorMsg = 'خطایی رخ داده لطفا بعدم امتحان کنید';
        });
        return;
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ApplicationBar(context),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[20],
          width: size.width,
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 0),
                width: size.width,
                height: 150,
                child: Image.asset('assets/images/Rosena_ir.png', width: 350),
              ),
              Container(
                padding: EdgeInsets.all(0),
                width: size.width,
                alignment: Alignment.center,
                height: 75,
                child: Text(
                  'ثبت نام در فروشگاه اینترنتی رزنا',
                  style: TextStyle(
                    height: 1.5,
                    fontFamily: "Yekan",
                    fontSize: 16,
                    color: Colors.pink,
                  ),
                ),
              ),
              Container(
                width: size.width / 1.5,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  _errorMsg.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Yekan',
                    height: 1.5,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Container(
                  width: size.width / 1.5,
                  alignment: Alignment.centerRight,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 22, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 1,
                      ),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'Yekan',
                            ),
                            children: [
                              WidgetSpan(child: Icon(Icons.phone_android)),
                              TextSpan(
                                text: 'َشماره موبایل:',
                              ),
                            ]),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            helperText:
                                'شماره خود را به صورت انگلیسی وارد کنید'),
                        controller: _mobileController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'Yekan',
                            ),
                            children: [
                              WidgetSpan(child: Icon(Icons.lock_open)),
                              TextSpan(
                                text: 'انتخاب رمز ورود:',
                              ),
                            ]),
                      ),
                      TextField(
                        decoration: InputDecoration(),
                        controller: _passwordController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        elevation: 1,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5),
                        ),
                        color: Colors.pink,
                        textColor: Colors.white,
                        onPressed: () => _submitData(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                width: size.width / 1.5,
                child: new InkWell(
                  child: new Text(
                    'حساب کاربری دارید؟ ورود',
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    return Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondAnimation) {
                          return LoginPage();
                        }));
                  },
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}
