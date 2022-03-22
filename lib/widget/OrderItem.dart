import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosena/model/OrderModel.dart';
import '../pages/user/UserOrderBasket.dart';


class OrderItem extends StatelessWidget {
  final OrderModel _order;

  OrderItem(this._order);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ProductPage(_order)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (_order.order_position.toString() == '0')
                OrderPosition(
                    'درحال بررسی', Icons.access_time, Colors.blueAccent),
              if (_order.order_position.toString() == '1')
                OrderPosition('تایید شده در حال آماده سازی',
                    Icons.playlist_add_check, Colors.green),
              if (_order.order_position.toString() == '2')
                OrderPosition(
                    'درحال ارسال', Icons.local_shipping, Colors.orange),
              if (_order.order_position.toString() == '3')
                OrderPosition(
                    'سفارش شما لغو شد', Icons.error_outline, Colors.red),
              if (_order.order_position.toString() == '4')
                OrderPosition('سفارش شما تکمیل شد', Icons.check, Colors.green),
              if (_order.order_position.toString() == '5')
                OrderPosition(
                    'سفارش شما تکمیل و پایان یافت', Icons.check, Colors.green),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
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
                            Icons.bookmark,
                            color: Colors.yellow[800],
                          ),
                        ),
                      ),
                      TextSpan(text: 'شماره فاکتور: '),
                      TextSpan(
                        text: _order.factor_number.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
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
                          child: Icon(Icons.calendar_today),
                        ),
                      ),
                      TextSpan(
                        text: 'تاریخ سفارش: ',
                      ),
                      TextSpan(
                        text: _order.jdate.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
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
                          child: Icon(Icons.monetization_on,
                              color: Colors.green[900]),
                        ),
                      ),
                      TextSpan(
                        text: 'مبلغ کل: ',
                      ),
                      TextSpan(
                        text: _order.final_price.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
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
                          child: _order.gateway == 'SUCCESS'
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                        ),
                      ),
                      TextSpan(
                        text: 'وضعیت پرداخت: ',
                      ),
                      _order.gateway == 'SUCCESS' ?
                      TextSpan(
                        text: 'پرداخت شده ', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,)

                      ) : TextSpan(
                          text: 'پرداخت نشده ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,)

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
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
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'گیرنده: ',
                      ),
                      TextSpan(
                        text: _order.re_name.toString() +
                            ' - ' +
                            _order.re_mobile.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(bottom: 5),
                child: RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: TextStyle(
                        fontFamily: 'Yekan',
                        fontSize: 20,
                        color: Colors.grey[800],
                        height: 1.5),
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0, left: 15),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'آدرس: ',
                      ),
                      TextSpan(
                        text: _order.re_country.toString() +
                            ',' +
                            _order.re_city.toString() +
                            ',' +
                            _order.re_address.toString() +
                            ' - ' +
                            _order.re_post_code.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  return Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => UserOrderBasket(_order.id.toString())));
                },
                color: Colors.pink,
                textColor: Colors.white,
                child: Text(
                  'نمایش جزئیات سفارش',
                  style: TextStyle(
                    fontFamily: 'Yekan'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderPosition extends StatelessWidget {
  final String _text;
  var _icon;
  var _color;

  OrderPosition(this._text, this._icon, this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Yekan',
                  fontSize: 18,
                  color: _color,
                ),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0, left: 15),
                      child: Icon(
                        _icon,
                        color: _color,
                      ),
                    ),
                  ),
                  TextSpan(text: 'وضعیت سفارش: '),
                  TextSpan(
                    text: _text.toString(),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey)
        ],
      ),
    );
  }
}
