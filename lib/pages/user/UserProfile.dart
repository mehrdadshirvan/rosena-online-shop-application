import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../inc/ApplicationBarUserProfile.dart';
import '../../inc/ButtomNavigation.dart';
import '../../main.dart';
import '../../pages/AboutUsPage.dart';
import '../../pages/user/UserInfo.dart';
import '../../pages/user/UserLove.dart';
import '../../pages/user/UserOrders.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var _access_token, _refresh_token, _token_type,_address_array;

  @override
  void initState() {
    super.initState();
    _loadTokey();
  }

  //Loading counter value on start
  _loadTokey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _access_token = prefs.getString('access_token');
      _refresh_token = prefs.getString('refresh_token');
      _token_type = prefs.getString('token_type');
    });
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _access_token = prefs.remove('access_token');
    _refresh_token = prefs.remove('refresh_token');
    _token_type = prefs.remove('token_type');
    _address_array = prefs.remove('address_array');

    setState(() {
      _access_token = _refresh_token = _token_type = null;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Main(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBarUserProfile(context,_logOut),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: (){
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => UserInfo()));

                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            height: 2,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Yekan',
                            fontSize: 23
                          ),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Icon(Icons.person, color: Colors.grey,size: 35,),
                              ),
                            ),
                            TextSpan(
                              text: 'ویرایش اطلاعات',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => UserOrders()));
                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              height: 2,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Yekan',
                              fontSize: 23
                          ),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Icon(Icons.shopping_basket, color: Colors.blueAccent,size: 35,),
                              ),
                            ),
                            TextSpan(
                              text: 'لیست سفارشات',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => UserLove()));
                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              height: 2,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Yekan',
                              fontSize: 23
                          ),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Icon(Icons.favorite, color: Colors.red,size: 35,),
                              ),
                            ),
                            TextSpan(
                              text: 'علاقه مندی ها',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey,
                              height: 2,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Yekan',
                              fontSize: 23
                          ),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15),
                                child: Icon(Icons.account_box, color: Colors.purple,size: 35,),
                              ),
                            ),
                            TextSpan(
                              text: 'درباره ما',
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
      bottomNavigationBar: ButtomNavigation(),
    );
  }
}
