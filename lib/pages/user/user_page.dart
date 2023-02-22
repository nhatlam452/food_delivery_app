import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';

import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
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
                                  text: userController.userModel.name,
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
                                  text: userController.userModel.phone,
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
                                  text: userController.userModel.email,
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
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.find<CartController>().clear();

                                    Get.offNamed(RouteHelper.getInitial());
                                  }
                                },
                                child: AccountWidget(
                                  icon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.red,
                                    iconColor: Colors.white,
                                    size: Dimension.height10 * 5,
                                    iconSize: Dimension.height10 * 5 / 2,
                                  ),
                                  text: BigText(
                                    text: "Log out",
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimension.height20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : CustomLoader())
              : Container(
                  child: Center(
                    child: Container(
                      width: double.maxFinite,
                      height: Dimension.height20 * 8,
                      margin: EdgeInsets.only(
                          left: Dimension.width20, right: Dimension.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/image/ic_logo_green.png'))),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
