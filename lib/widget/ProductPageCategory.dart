import 'package:flutter/material.dart';
import '../model/CategoryModel.dart';
import '../pages/category/CategoryPage.dart';

class ProductPageCategory extends StatelessWidget {
  final CategoryModel _category;
  ProductPageCategory(this._category);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=> CategoryPage(_category.ename_url)
          ));
        },
        child: Text(
          _category.name
        ),
      ),
    );
  }
}
