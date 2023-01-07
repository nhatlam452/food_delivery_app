import 'package:flutter/material.dart';
import 'package:food_delivery_app/util/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow textOverflow;

  BigText(
      {Key? key,
      this.color = const Color(0xFF89dad0),
      required this.text,
      this.size = 0,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: size==0?Dimension.font20:size,
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
