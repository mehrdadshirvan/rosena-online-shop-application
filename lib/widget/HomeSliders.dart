import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rosena/model/HomeSliderModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/brand/BrandPage.dart';
import '../pages/category/CategoryPage.dart';

class HomeSliders extends StatelessWidget {
  List<HomeSliderModel> _sliderList = [];
  HomeSliders(this._sliderList);
  @override
  Widget build(BuildContext context) {
    return _sliderList.isNotEmpty
        ? Container(
            height: 170,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 155.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.5,
                  ),
                  items: _sliderList
                      .map((item) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              // color: Colors.white,
                              // boxShadow: [
                              //   BoxShadow(color: Colors.pink, spreadRadius: 3),
                              // ],
                            ),
                            child: Row(
                              children: <Widget>[
                                if (item.category != '0')
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryPage(item.category
                                                      .toString())));
                                    },
                                    child: Image.network(
                                      'https://www.rosena.ir' +
                                          item.img_url.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (item.brand != '0')
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => BrandPage(
                                                  item.brand.toString())));
                                    },
                                    child: Image.network(
                                      'https://www.rosena.ir' +
                                          item.img_url.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (item.link_to != '0')
                                  InkWell(
                                    onTap: () {
                                      launch(item.link_to.toString());
                                    },
                                    child: Image.network(
                                      'https://www.rosena.ir' +
                                          item.img_url.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          )
        : Container();
  }
}

