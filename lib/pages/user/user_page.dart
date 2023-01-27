import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimension.height20),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppIcon(
                  icon: CupertinoIcons.person_alt,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  size: Dimension.height15 * 10,
                  iconSize: Dimension.height15 * 5,
                ),
                SizedBox(
                  height: Dimension.height30,
                ),
                //name
                AccountWidget(
                  icon: AppIcon(
                    icon: CupertinoIcons.person_alt,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimension.height10 * 5,
                    iconSize: Dimension.height10 * 5 / 2,
                  ),
                  text: BigText(
                    text: "Nguyen Nhat Lam",
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                //phone
                AccountWidget(
                  icon: AppIcon(
                    icon: CupertinoIcons.phone_fill,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimension.height10 * 5,
                    iconSize: Dimension.height10 * 5 / 2,
                  ),
                  text: BigText(
                    text: "090****020",
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                //email
                AccountWidget(
                  icon: AppIcon(
                    icon: CupertinoIcons.mail_solid,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimension.height10 * 5,
                    iconSize: Dimension.height10 * 5 / 2,
                  ),
                  text: BigText(
                    text: "nhatlam452@gmail.com",
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                //address
                AccountWidget(
                  icon: AppIcon(
                    icon: CupertinoIcons.location_fill,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimension.height10 * 5,
                    iconSize: Dimension.height10 * 5 / 2,
                  ),
                  text: BigText(
                    text: "Fill your address",
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                //message
                AccountWidget(
                  icon: AppIcon(
                    icon: Icons.message,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimension.height10 * 5,
                    iconSize: Dimension.height10 * 5 / 2,
                  ),
                  text: BigText(
                    text: "Contact us",
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
