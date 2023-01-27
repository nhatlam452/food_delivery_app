import 'package:flutter/material.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon icon;
  BigText text;

  AccountWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimension.width20,
          top: Dimension.height10,
          bottom: Dimension.height10),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: Dimension.width20,
          ),
          text
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
    );
  }
}
