import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:food_delivery_app/auth/sign_in_page.dart';
import 'package:food_delivery_app/base/show_toast.dart';
import 'package:food_delivery_app/model/sign_up_body_model.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../base/custom_loader.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var signUpImages = [
      "logo_fb.png",
      "logo_gg.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      if (name.isEmpty) {
        showCustomToast("Type in your Name", title: "Name is Empty");
      } else if (phone.isEmpty) {
        showCustomToast("Type in your Phone", title: "Phone Number is Empty");
      } else if (email.isEmpty) {
        showCustomToast("Type in your Email", title: "Email is Empty");
      } else if (!GetUtils.isEmail(email)) {
        showCustomToast("Please type exactly your email", title: "Email is invalid");
      } else if (password.isEmpty) {
        showCustomToast("Type in your password", title: "Password is Empty");
      } else if (confirmPassword.isEmpty) {
        showCustomToast("Type in your confirm password", title: "Confirm Password is Empty");
      } else if (password.length <= 6) {
        showCustomToast("Password can not be less than 6 characters", title: "Password is invalid");
      } else if (confirmPassword.compareTo(password) != 0) {
        showCustomToast("Please check your password and confirm password", title: "Confirm password doesn't match");
      } else {
        SignUpBody signUpBody = SignUpBody(name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("success");
          }else{
            showCustomToast(status.msg);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return _authController.isLoading?SingleChildScrollView(
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
              AppTextField(
                icon: CupertinoIcons.mail,
                textEditingController: emailController,
                hintText: "Email",
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                icon: CupertinoIcons.phone,
                textEditingController: phoneController,
                hintText: "Phone Number",
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                icon: CupertinoIcons.person_circle,
                textEditingController: nameController,
                hintText: "Name",
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
              AppTextField(
                icon: Icons.confirmation_num_outlined,
                textEditingController: confirmPasswordController,
                hintText: "Confirm Password",
                isOb: true,

              ),
              SizedBox(
                height: Dimension.height30,
              ),
              GestureDetector(
                onTap: () {
                  _registration(_authController);
                },
                child: Container(
                  width: Dimension.screenWidth / 3,
                  height: Dimension.screenHeight / 18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30 / 2),
                      color: AppColors.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      color: Colors.white,
                      size: Dimension.font20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimension.height20,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignInPage(),
                            transition: Transition.fade),
                      text: "Have an account already ?",
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: Dimension.font16))),
              SizedBox(
                height: Dimension.height10,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.back,
                      text: "Or",
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: Dimension.font20 - Dimension.font20 / 3))),
              Wrap(
                  children: List.generate(
                      signUpImages.length,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimension.radius30,
                          backgroundImage: AssetImage(
                              "assets/image/" + signUpImages[index]),
                          backgroundColor: Colors.white,
                        ),
                      )))
            ],
          ),
        ):CustomLoader();
      },),
    );
  }
}
