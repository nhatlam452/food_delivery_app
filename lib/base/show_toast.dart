import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import "package:get/get.dart";

void showCustomToast(String msg,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, msg,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent
  );

}
