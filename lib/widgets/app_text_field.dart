
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/colors.dart';
import '../util/dimensions.dart';

class AppTextField extends StatelessWidget {
final TextEditingController textEditingController;
final String hintText ;
final IconData icon;
bool isOb;
AppTextField({Key? key, required this.textEditingController, required this.hintText, required this.icon,this.isOb = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimension.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimension.radius30 / 2) ,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
          obscureText: isOb?true:false,
          cursorColor: AppColors.mainColor,
          controller: textEditingController,
          decoration: InputDecoration(
            label: Text(hintText),
            labelStyle: TextStyle(color: AppColors.mainColor),
            prefixIcon: Icon(
              icon,
              color: AppColors.mainColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius30 / 2),
                borderSide:
                BorderSide(width: 1.0, color: AppColors.mainColor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30 / 2),
              borderSide:
              BorderSide(width: 1.0, color: AppColors.mainColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius30 / 2),
            ),
          )

      ),
    );
  }
}
