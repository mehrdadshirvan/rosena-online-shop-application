import 'package:flutter/material.dart';

class FakeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.only(bottom: 5),
        child: RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Yekan',
              fontSize: 14,
              color: Colors.grey[800],
            ),
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, left: 15),
                  child:
                      Icon(Icons.remove_circle_outline, color: Colors.orange),
                ),
              ),
              TextSpan(
                text: 'این محصول توسط تولید کننده اصلی (برند) تولید نشده است',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
