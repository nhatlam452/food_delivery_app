import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:food_delivery_app/auth/sign_up_page.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../base/show_toast.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomToast("Type in your Phone", title: "Phone Number is Empty");
      } else if (password.isEmpty) {
        showCustomToast("Type in your password", title: "Password is Empty");
      } else if (password.length <= 5) {
        showCustomToast("Password can not be less than 5 characters",
            title: "Password is invalid");
      } else {
        authController.login(email,password).then((status) {
          if (status.isSuccess) {
            print("ok");
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomToast(status.msg);
            print(status.msg);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              Container(
                height: Dimension.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/image/ic_logo_green.png"),
                  ),
                ),
              ),
              Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: Dimension.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Hello ",
                        size: Dimension.font26 + Dimension.font20,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SmallText(
                        text: "Sign into your account !",
                        size: Dimension.font20 - 5,
                      ),
                    ],
                  )),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              AppTextField(
                icon: CupertinoIcons.phone,
                textEditingController: emailController,
                hintText: "Phone Number",
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                icon: Icons.password_outlined,
                textEditingController: passwordController,
                hintText: "Password",
                isOb: true,
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back,
                          text: "Forgot password ?",
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimension.font16))),
                  SizedBox(
                    width: Dimension.width20,
                  )
                ],
              ),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimension.screenWidth / 3,
                  height: Dimension.screenHeight / 18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30 / 2),
                      color: AppColors.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      color: Colors.white,
                      size: Dimension.font20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(SignUpPage());
                },
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account ? ",
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimension.font20),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignUpPage(),
                                  transition: Transition.fade),
                            text: " Sign up",
                            style: TextStyle(
                                color: AppColors.mainBlackColor,
                                fontSize: Dimension.font20))
                      ]),
                ),
              ),
            ],
          ),
        ):CustomLoader();
      },),
    );
  }
}
