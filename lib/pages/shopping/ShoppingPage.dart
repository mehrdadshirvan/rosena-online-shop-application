import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../inc/ApplicationBarJustBackBtn.dart';
import '../../main.dart';
import '../../model/CountryModel.dart';
import 'FinalFactorPage.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final List<AddressModel> _address_model = [];
  final List<CountryModel> _countryItem = [];
  final _re_name_Controller = TextEditingController();
  final _re_mobile_Controller = TextEditingController();
  final _re_address_Controller = TextEditingController();
  final _re_post_code_Controller = TextEditingController();

  String _errorMsg = '';
  String _token_type;
  String _expires_in;
  String _access_token;
  String _refresh_token;

  String _at;
  String _tt;
  var _ar;
  var _aarr = [];
  String _ar_name;
  String _ar_mobile;
  String _ar_address;
  String _ar_post_code;
  String _ar_country_id;

  @override
  void initState() {
    super.initState();
    _checkToken();
    _getCity();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _re_name_Controller.dispose();
    _re_mobile_Controller.dispose();
    _re_address_Controller.dispose();
    _re_post_code_Controller.dispose();
    super.dispose();
  }

  void _getCity() async {
    var url = 'https://www.rosena.ir/api/app/country';
    Response response = await get(url);
    setState(() {
      var dataJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in dataJson) {
        var _item = CountryModel(
          i['id'].toString(),
          i['name'].toString(),
        );
        _countryItem.add(_item);
      }
    });
  }

  //Loading counter value on start
  _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _at = prefs.getString('access_token');
      _tt = prefs.getString('token_type');
      _ar = prefs.getString('address_array');
    });
    if (_tt.isEmpty && _at.isEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Main(),
        ),
      );
    }
    _refresh_address(_ar);
  }

  //Loading counter value on start
  _loadTokey(keyName, value) async {
    SharedPreferences newAdd = await SharedPreferences.getInstance();
    setState(() {
      newAdd.setString(keyName, value);
    });
  }

  void _refresh_address(_ar) async {
    if (_ar != null) {
      setState(() {
        var dataJson = json.decode(_ar);
        for (var i in dataJson) {
          var _it = AddressModel(
            i['name'].toString(),
            i['mobile'].toString(),
            i['country'].toString(),
            i['address'].toString(),
            i['post_code'].toString(),
          );
          _address_model.add(_it);
        }
      });
    }
  }


  void _checkAndCountinue() async {
    if (_ar == null) {
      final _enteredReName = _re_name_Controller.text.toString();
      final _enteredReMobile = _re_mobile_Controller.text.toString();
      final _enteredReAddress = _re_address_Controller.text.toString();
      final _enteredRePostCode = _re_post_code_Controller.text.toString();
      final _enteredReCountry = _ar_country_id;
      final _address_array = [];
      final _address_model = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var delete_address_array = prefs.remove('address_array');
      setState(() {
        _errorMsg = '';
      });
      if (_enteredReName.isEmpty) {
        setState(() {
          _errorMsg = 'نام و نام خانوادگی گیرنده را وارد کنید';
        });
        return;
      }
      if (_enteredReMobile.isEmpty) {
        setState(() {
          _errorMsg = 'شماره موبایل را وارد کنید';
        });
        return;
      }
      if (_enteredReCountry == null) {
        setState(() {
          _errorMsg = 'استان و شهر مورد نظر را انتخاب کنید';
        });
        return;
      }
      if (_enteredReAddress.isEmpty || _enteredReAddress.length < 10) {
        setState(() {
          _errorMsg = 'آدرس را به درستی وارد کنید';
        });
        return;
      }
      if (_enteredRePostCode.isEmpty) {
        setState(() {
          _errorMsg = 'کدپستی را به درستی واردکنید';
        });
        return;
      }

      setState(() {
        _errorMsg = 'درحال بررسی...';
      });

      var js = {
        "name": _enteredReName.toString(),
        "mobile": _enteredReMobile.toString(),
        "country": _enteredReCountry.toString(),
        "address": _enteredReAddress.toString(),
        "post_code": _enteredRePostCode.toString(),
      };
      _address_array.add(js);

      _loadTokey('address_array', json.encode(_address_array));

      setState(() {
        _ar = _address_array;
        _errorMsg = '';
      });
      _refresh_address(_ar);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FinalFactorPage(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FinalFactorPage(),
        ),
      );
    }
  }

  void _addNewAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final _address_array = [];
      var delete_address_array = prefs.remove('address_array');
      _ar = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarJustBackBtn(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerRight,
                height: 75,
                child: RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      fontSize: 20,
                      color: Colors.grey[800],
                    ),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0, left: 15),
                          child: Icon(
                            Icons.person,
                            color: Colors.yellow[800],
                          ),
                        ),
                      ),
                      TextSpan(text: 'اطلاعات گیرنده:'),
                    ],
                  ),
                ),
              ),
              if (_errorMsg.isNotEmpty)
                Container(
                  child: Text(
                    '*' + _errorMsg.toString() + '*',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.red, fontFamily: 'yekan', fontSize: 18),
                  ),
                ),
              SizedBox(
                height: 5,
              ),
              _ar == null
                  ? Container(
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        alignment: Alignment.centerRight,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 22, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          verticalDirection: VerticalDirection.down,
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'نام و نام خوانوادگی گیرنده:',
                              style: TextStyle(
                                  fontFamily: 'Yekan', color: Colors.grey[600]),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            TextField(
                              controller: _re_name_Controller,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'شماره موبایل:',
                              style: TextStyle(
                                  fontFamily: 'Yekan', color: Colors.grey[600]),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            TextField(
                              controller: _re_mobile_Controller,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'استان:',
                              style: TextStyle(
                                  fontFamily: 'Yekan', color: Colors.grey[600]),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: DropdownButton<String>(
                                    items: _countryItem.map((i) {
                                      return new DropdownMenuItem<String>(
                                        value: i.id.toString(),
                                        child: Text(i.name.toString(),textDirection: TextDirection.rtl,textAlign: TextAlign.right,),
                                      );
                                    }).toList(),
                                    value: _ar_country_id,
                                    icon: Icon(Icons.expand_more),
                                    onChanged: (i) {
                                      setState(() {
                                        _ar_country_id = i.toString();
                                      });
                                    },
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'آدرس دقیق پستی:',
                              style: TextStyle(
                                  fontFamily: 'Yekan', color: Colors.grey[600]),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            TextField(
                              maxLines: 6,
                              controller: _re_address_Controller,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'کدپستی:',
                              style: TextStyle(
                                  fontFamily: 'Yekan', color: Colors.grey[600]),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            TextField(
                              controller: _re_post_code_Controller,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if(_address_model.isNotEmpty) Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(left: 30, right: 30,bottom: 20),
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 15),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.pink[800],
                                      ),
                                    ),
                                  ),
                                  TextSpan(text: 'گیرنده: '),
                                  TextSpan(
                                    text: _address_model[0].name.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(_address_model.isNotEmpty) Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(left: 30, right: 30,bottom: 20),
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 15),
                                      child: Icon(
                                        Icons.phone_android,
                                        color: Colors.pink[800],
                                      ),
                                    ),
                                  ),
                                  TextSpan(text: 'شماره موبایل: '),
                                  TextSpan(
                                    text: _address_model[0].mobile.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(_address_model.isNotEmpty) Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(left: 30, right: 30,bottom: 20),
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 15),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.pink[800],
                                      ),
                                    ),
                                  ),
                                  TextSpan(text:'آدرس پستی: '),
                                  TextSpan(
                                    text: _address_model[0].address.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(_address_model.isNotEmpty) Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(left: 30, right: 30,bottom: 20),
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Yekan',
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 15),
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.pink[800],
                                      ),
                                    ),
                                  ),
                                  TextSpan(text:'کدپستی: '),
                                  TextSpan(
                                    text: _address_model[0].post_code.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationShopping(_checkAndCountinue),
      floatingActionButton: _ar != null ? Container(
        width: MediaQuery.of(context).size.width / 2,
        child: RaisedButton(
          onPressed: () => _addNewAddress(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.blueAccent)
          ),
          elevation: 5,
          padding: EdgeInsets.only(top: 15,bottom: 15),
          child: RichText(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Yekan',
              ),
              children: [
                WidgetSpan(
                  child: Icon(Icons.add,size: 18,),
                ),
                TextSpan(
                    text: 'افزودن آدرس جدید',
                ),
              ]
            ),
          ),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class BottomNavigationShopping extends StatelessWidget {
  final Function _checkAndCountinue;

  BottomNavigationShopping(this._checkAndCountinue);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      color: Colors.white,
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: RaisedButton(
                    onPressed: () => _checkAndCountinue(),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'ثبت آدرس و نمایش فاکتور'),
                          TextSpan(
                            text: '   ',
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 0, left: 15),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddressModel {
  final String _name;
  final String _mobile;
  final String _country;
  final String _address;
  final String _post_code;

  AddressModel(this._name, this._mobile, this._country, this._address, this._post_code);

  String get post_code => _post_code;

  String get address => _address;

  String get country => _country;

  String get mobile => _mobile;

  String get name => _name;
}
