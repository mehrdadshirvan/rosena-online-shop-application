import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../pages/auth/ForgetPasswordPage.dart';
import '../../pages/auth/LoginPage.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  String _errorMsg = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitData() async {
    final _enteredMobile = _mobileController.text.toString();
    final _enteredPassword = _passwordController.text.toString();
    final _enteredcode = _codeController.text.toString();
    setState(() {
      _errorMsg = '';
    });
    if (_mobileController.text.isEmpty) {
      setState(() {
        _errorMsg = 'شماره موبایل خود را وارد کنید';
      });
      return;
    }
    if (_enteredcode.isEmpty) {
      setState(() {
        _errorMsg = 'کد وارد شده صحیح نمیباشد';
      });
      return;
    }
    if (_enteredPassword.length <= 5 || _enteredPassword.isEmpty) {
      setState(() {
        _errorMsg = 'رمز ورود نامعتبر است';
      });
      return;
    }

    var _user_id = 9092301030; //_getUserId();
    var client = http.Client();
    print('start connection');
    setState(() {
      _errorMsg = 'درحال بررسی اطلاعات';
    });
    try {
      var uriResponse =
          await client.post('https://www.rosena.ir/api/resetpassword', headers: {
        'Accept': 'application/json'
      }, body: {
        'username': _enteredMobile.toString(),
        'password': _enteredPassword.toString(),
        'code': _enteredcode.toString(),
      });
      print('Response status: ${uriResponse.statusCode}');
      print('Response body: ${uriResponse.body}');
      if (uriResponse.body == "ok") {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage()));
        setState(() {
          _errorMsg = '';
        });
      }else if(uriResponse.body == "user_not_found"){
        setState(() {
          _errorMsg = 'کاربر مورد نظر یافت نشد';
        });
      }else if(uriResponse.body == "code_not_found"){
        setState(() {
          _errorMsg = 'کد تایید درست نمیباشد';
        });
      }else if(uriResponse.body == "not_match"){
        setState(() {
          _errorMsg = 'شماره موبایل و کد تایید را بررسی کنید';
        });
      } else {
        setState(() {
          _errorMsg = 'خطایی رخ داده لطفا بعدم امتحان کنید';
        });
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.of(context).size;
    return Scaffold(
      appBar: ApplicationBar(context),
      body: SingleChildScrollView(
        child: Container(
          width:size.width,
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 0),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Image.asset('assets/images/Rosena_ir.png', width: 350),
              ),
              Container(
                padding: EdgeInsets.all(0),
                width: size.width,
                alignment: Alignment.center,
                height: 75,
                child: Text(
                  'تغیر رمز عبور',
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
                      SizedBox(height: 1,),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'Yekan',

                            ),
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.phone_android)
                              ),
                              TextSpan(
                                text: 'َشماره موبایل:',
                              ),
                            ]
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          helperText: 'شماره خود را به صورت انگلیسی وارد کنید',
                        ),
                        controller: _mobileController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'Yekan',

                            ),
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.lock_open)
                              ),
                              TextSpan(
                                text: 'َرمز عبور جدید:',
                              ),
                            ]
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          helperText:
                              'رمز عبور شما باید بیشت از 8 حرف/عدد باشد',
                        ),
                        controller: _passwordController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 1,),
                      RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'Yekan',

                            ),
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.message)
                              ),
                              TextSpan(
                                text: ' کد بازیابی: ',
                              ),
                            ]
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          helperText: 'کد ارسال شده به شماره موبایل شما',
                        ),
                        controller: _codeController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        elevation: 1,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'ورود',
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
                      SizedBox(height: 20,),
                      Container(
                        child: Text(
                          'ارسال کد ممکن است بین 1-5 دقیقه طول بکشد',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Yekan',
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width / 1.5,
                child: new InkWell(
                  child: new Text(
                    'ارسال دوباره رمز ورود',
                    style: TextStyle(
                        fontFamily: 'Yekan', fontSize: 14, height: 2.5),
                  ),
                  onTap: () {
                    return Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondAnimation) {
                          return ForgetPasswordPage();
                        }));
                  },
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}
