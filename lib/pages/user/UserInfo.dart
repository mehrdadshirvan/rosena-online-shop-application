import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../inc/ApplicationBarJustBackBtn.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController _user_name = new TextEditingController();
  TextEditingController _user_mobile = new TextEditingController();
  TextEditingController _user_email = new TextEditingController();
  TextEditingController _user_cart_number = new TextEditingController();
  final List<UserInfoModel> _items = [];
  List _genderItem = [
    {'value': 'man', 'title': 'مرد'},
    {'value': 'woman', 'title': 'زد'},
  ];
  var _access_token, _token_type, _address_array;
  String _errorMsg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTokey();
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   _user_name.dispose();
  //   _user_mobile.dispose();
  //   _user_email.dispose();
  //   _user_cart_number.dispose();
  //   super.dispose();
  // }

  //Loading counter value on start
  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _token_type = prefs.getString('token_type');
      _address_array = prefs.getString('address_array');
      _errorMsg = "درحال دریافت اطلاعات...";
      _getUserInfo();
    });
  }

  void _getUserInfo() async {
    if (_token_type != null && _access_token != null) {
      var _authorization = _token_type + ' ' + _access_token.toString();
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/user/getinfo', headers: {
          'Accept': 'application/json',
          'Authorization': _authorization
        });
        if (uriResponse.body.isNotEmpty) {
          var response = uriResponse.body;
          setState(() {
            var dataJson = json.decode(response);
            for (var i in dataJson) {
              var _it = UserInfoModel(
                i['user_name'].toString(),
                i['user_mobile'].toString(),
                i['user_email'].toString(),
                i['user_cart_number'].toString(),
              );
              _items.add(_it);
            }
            setState(() {
              _user_name.text = _items[0].user_name.toString();
              _user_mobile.text = _items[0].user_mobile.toString();
              _user_email.text = _items[0].user_email.toString();
              _user_cart_number.text = _items[0].user_cart_number.toString();
              _errorMsg = "";
            });
          });
        } else {
          print('error');
        }
      } finally {
        client.close();
      }
    } else {
      return;
    }
  }

  void _submitData() async {
    if (_token_type != null && _access_token != null) {
      final _enteredName = _user_name.text.toString();
      final _enteredMobile = _user_mobile.text.toString();
      final _enteredEmail = _user_email.text.toString();
      final _enteredCart = _user_cart_number.text.toString();
      var _authorization = _token_type + ' ' + _access_token.toString();
      setState(() {
        _errorMsg = "درحال بررسی اطلاعات";
      });
      var client = http.Client();
      try {
        var uriResponse = await client
            .post('https://www.rosena.ir/api/user/updateinfo', headers: {
          'Accept': 'application/json',
          'Authorization': _authorization
        },body: {
              'name':_enteredName.toString(),
          'mobile':_enteredMobile.toString(),
          'email':_enteredEmail.toString(),
          'cart':_enteredCart.toString(),
        });
        //print(uriResponse.body);
        if (uriResponse.body == "ok"){
          setState(() {
            _errorMsg = "اطلاعات شما ذخیره و به روز شد.";
          });
        }else if(uriResponse.body == "email_exists"){
          setState(() {
            _errorMsg = "ایمیل وارد شده قبلا ثبت شده است.";
          });
        }else if(uriResponse.body == "mobile_exists"){
          setState(() {
            _errorMsg = "شماره وارد شده قبلا ثبت شده است.";
          });
        }
      } finally {
        client.close();
      }
      Navigator.pop(context, 'UserInfo');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: ApplicationBarJustBackBtn(context),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height - 100,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: size.width / 1.5,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    _errorMsg.toString(),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
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
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 22, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      verticalDirection: VerticalDirection.down,
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'نام و نام خوانوادگی:',
                          style:
                              TextStyle(fontFamily: 'Yekan', color: Colors.grey[600]),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        TextField(
                          controller: _user_name,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'شماره موبایل:',
                          style:
                              TextStyle(fontFamily: 'Yekan', color: Colors.grey[600]),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        TextField(
                          controller: _user_mobile,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'ایمیل:',
                          style:
                              TextStyle(fontFamily: 'Yekan', color: Colors.grey[600]),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        TextField(
                          controller: _user_email,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'شماره کارت بانکی:',
                          style:
                              TextStyle(fontFamily: 'Yekan', color: Colors.grey[600]),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        TextField(
                          controller: _user_cart_number,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width / 2,
                    child: RaisedButton(
                      onPressed: () => _submitData(),
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: Text(
                        'ذخیره و به روز رسانی',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Yekan'
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoModel {
  final String _user_name;
  final String _user_mobile;
  final String _user_email;
  final String _user_cart_number;

  UserInfoModel(this._user_name, this._user_mobile, this._user_email,
      this._user_cart_number);


  String get user_cart_number => _user_cart_number;

  String get user_email => _user_email;

  String get user_mobile => _user_mobile;

  String get user_name => _user_name;
}

class genderModel {
  final String _value;
  final String _title;

  genderModel(this._value, this._title);

  String get title => _title;

  String get value => _value;
}
