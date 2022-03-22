import 'package:flutter/material.dart';

class ProductSortWidget extends StatelessWidget {
  final Function _listFilter;
    ProductSortWidget(this._listFilter);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        color: Colors.white,
        // backgroundBlendMode: BlendMode.hardLight,
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          SizedBox(height: 6,),
          Icon(Icons.maximize,color: Colors.grey.shade700,size: 30,),
          Text(
            'فیلتر بر اساس',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Yekan',
              fontSize: 18,
              color: Colors.grey.shade700
            ),
          ),
          SizedBox(height: 6,),
          Container(
            width: size.width,
            child: InkWell(
              onTap: () => _listFilter('inexpensive'),
              child: Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontFamily: 'Yekan',
                      fontWeight: FontWeight.normal,
                      fontSize: 20
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.trending_down,size: 20,)
                      ),
                      TextSpan(
                        text: ' ارزان ترین',
                      )
                    ]
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.5,color: Colors.grey.shade300,),
          Container(
            width: size.width,
            child: InkWell(
              onTap: () => _listFilter('expensive'),
              child: Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                      ),
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.trending_up,size: 20,)
                        ),
                        TextSpan(
                          text: ' گران ترین',
                        )
                      ]
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.5,color: Colors.grey.shade300,),
          Container(
            width: size.width,
            child: InkWell(
              onTap: () => _listFilter('newest'),
              child: Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                      ),
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.hourglass_empty,size: 20,)
                        ),
                        TextSpan(
                          text: ' جدیدترین',
                        )
                      ]
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.5,color: Colors.grey.shade300,),
          Container(
            width: size.width,
            child: InkWell(
              onTap: () => _listFilter('popularity'),
              child: Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                      ),
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.favorite_border,size: 20,)
                        ),
                        TextSpan(
                          text: ' محبوب ترین',
                        )
                      ]
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1.5,color: Colors.grey.shade300,),
          Container(
            width: size.width,
            child: InkWell(
              onTap: () => _listFilter('sell'),
              child: Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                      ),
                      children: [
                        WidgetSpan(
                            child: Icon(Icons.show_chart,size: 20,)
                        ),
                        TextSpan(
                          text: ' پرفروش ترین',
                        )
                      ]
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );

  }
}
