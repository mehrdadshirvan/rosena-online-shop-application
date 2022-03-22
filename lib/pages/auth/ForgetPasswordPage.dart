import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../inc/ApplicationBar.dart';
import '../../inc/ButtomNavigation.dart';
import '../../pages/auth/ResetPasswordPage.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _mobileController = TextEditingController();

  String _errorMsg = '';
  var _action;
  int _sending = 0;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _mobileController.dispose();
    super.dispose();
  }

  void _submitData() async {
    final _enteredMobile = _mobileController.text.toString();
    setState(() {
      _errorMsg = '';
    });
    if (_mobileController.text.isEmpty) {
      setState(() {
        _errorMsg = 'شماره موبایل خود را وارد کنید';
        _sending = 0;
      });
      return;
    }

    var _user_id = 9092301030; //_getUserId();
    var client = http.Client();
    // print('start connection');
    setState(() {
      _errorMsg = 'درحال بررسی اطلاعات';
    });
    try {
      var uriResponse =
      await client.post('https://www.rosena.ir/api/forgetpassword', headers: {
        'Accept': 'application/json'
      }, body: {
        'username': _enteredMobile.toString(),
      });
      // print('Response status: ${uriResponse.statusCode}');
      // print('Response body: ${uriResponse.body}');
      // print(uriResponse.body);
      if (uriResponse.body == 'ok') {
        setState(() {
          _errorMsg = '';
          _sending = 0;
        });
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ResetPasswordPage()));
      }else if(uriResponse.body == 'user_not_found'){
        setState(() {
          _errorMsg = 'کاربر یافت نشد';
          _sending = 0;
        });
      }else {
        setState(() {
          _errorMsg = 'خطایی رخ داده لطفا بعدم امتحان کنید';
          _sending = 0;
        });
      }
    } finally {
      client.close();
    }
  }

  void _sendcode(){
    setState(() {
      _sending = 1;
      _submitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ApplicationBar(context),
      body: SingleChildScrollView(
        child: Container(
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
                  'بازیابی رمز ورود',
                  style: TextStyle(
                    height: 1.5,
                    fontFamily: 'Yekan',
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
                          alignLabelWithHint:true,
                          helperText: 'شماره خود را به صورت انگلیسی وارد کنید'
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        controller: _mobileController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,

                      ),
                      SizedBox(height: 20),
                      _sending == 0 ? RaisedButton(
                        elevation: 1,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'بازیابی رمز',
                          style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5),
                        ),
                        color: Colors.pink,
                        textColor: Colors.white,
                        onPressed: () => _sendcode(),
                      ) : Container(
                        width: size.width,
                        child: Text(
                          'درحال ارسال کد...',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                            fontFamily: 'Yekan',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
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
