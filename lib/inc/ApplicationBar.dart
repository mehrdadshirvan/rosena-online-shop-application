import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rosena/pages/SearchPage.dart';
import '../pages/shopping/BasketPage.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Size get preferredSize => const Size.fromHeight(60);

  final BuildContext context;

  ApplicationBar(this.context);

  void _searchQuery() {
    final _enteredSearch = _searchController.text.toString();
    if (_enteredSearch.isNotEmpty && _enteredSearch != '') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SearchPage(_enteredSearch)));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      actions: <Widget>[
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  height: 40,
                  child: Form(
                    child: TextField(
                      onSubmitted: (_) {
                        if (_searchController.text != null) {
                          _searchQuery();
                        }
                      },
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      // keyboardType: TextInputType.go,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintStyle: TextStyle(
                            fontFamily: 'Yekan',
                            fontSize: 20,
                            color: Colors.grey),
                        hintText: 'جستجو در رزنا',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.only(top: 5, left: 35),
                        suffixIcon: IconButton(
                          onPressed: () => _searchQuery(),
                          icon: Icon(Icons.search),
                        ),
                        labelStyle: TextStyle(
                            fontFamily: 'Yekan',
                            fontSize: 20,
                            color: Colors.grey),
                        focusColor: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
