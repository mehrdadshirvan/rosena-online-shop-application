import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../pages/shopping/BasketPage.dart';
import '../pages/category/CategoryHomePage.dart';
import '../pages/user/UserProfile.dart';
import '../pages/auth/LoginPage.dart';
import '../pages/SearchPage.dart';

class ButtomNavigation extends StatefulWidget {
  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _selectedIndex = 0;
  var _access_token = null;

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
    });
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle _optionTextStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
    fontFamily: 'Yekan',
    color: Colors.black54,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      color: Colors.white,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          verticalDirection: VerticalDirection.up,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 35,
                        child: IconButton(
                          icon: Icon(
                            Icons.home,
                            color: Colors.black38,
                          ),
                          onPressed: () {
                            return Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondAnimation) {
                                  return Main();
                                }));
                          },
                        ),
                      ),
                      InkWell(
                        onTap:  () {
                          return Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondAnimation) {
                                return Main();
                              }));
                        },
                        child: Text(
                          'خانه',
                          style: _optionTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 35,
                        child: IconButton(
                          icon: Icon(
                            Icons.widgets,
                            color: Colors.black38,
                          ),
                          onPressed: () {
                            return Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondAnimation) {
                                  return CategoryHomePage();
                                }));
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          return Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondAnimation) {
                                return CategoryHomePage();
                              }));
                        },
                        child: Text(
                          'دسته بندی',
                          style: _optionTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 35,
                        child: IconButton(
                          icon: Icon(Icons.shopping_basket, color: Colors.black38),
                          onPressed: () {
                            return Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondAnimation) {
                                  return BasketPage();
                                }));
                          },
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          return Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondAnimation) {
                                return BasketPage();
                              }));
                        },
                        child: Text(
                          'سبدخرید',
                          style: _optionTextStyle,
                        ),
                      ),
                    ],
                  ),
                  if (_access_token == null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 35,
                          child: IconButton(
                            icon: Icon(Icons.person_outline, color: Colors.black38),
                            onPressed: () {
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
                        InkWell(
                          onTap:() {
                            return Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondAnimation) {
                                  return LoginPage();
                                }));
                          },
                          child: Text(
                            'ورود',
                            style: _optionTextStyle,
                          ),
                        ),
                      ],
                    ),
                  if (_access_token != null)
                    Column(
                      children: <Widget>[
                        Container(
                          height: 35,
                          child: IconButton(
                            icon: Icon(Icons.person, color: Colors.black38),
                            onPressed: () {
                              return Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 500),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondAnimation) {
                                    return UserProfile();
                                  }));
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            return Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondAnimation) {
                                  return UserProfile();
                                }));
                          },
                          child: Text(
                            'رزنای من',
                            style: _optionTextStyle,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
