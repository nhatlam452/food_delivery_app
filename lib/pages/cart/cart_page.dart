import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/pages/home/main_food_home.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimension.height10 * 3,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.iconSize24),
                    SizedBox(
                      width: Dimension.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(MainFoodHome());
                      },
                      child: AppIcon(
                          icon: Icons.home_outlined,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: Dimension.iconSize24),
                    ),
                    AppIcon(
                        icon: Icons.shopping_cart,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.iconSize24),
                  ])),
          Positioned(
              top: Dimension.height20 * 5,
              right: Dimension.width20,
              left: Dimension.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimension.height15),
                color: Colors.white,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: Dimension.height20 * 5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimension.height20 * 5,
                                  height: Dimension.height20 * 5,
                                  margin:
                                  EdgeInsets.only(bottom: Dimension.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+"/uploads/"+cartController.getItems[index].img!
                                          )),
                                      borderRadius: BorderRadius.circular(
                                          Dimension.radius20),
                                      color: Colors.white),
                                ),
                                SizedBox(width: Dimension.width10,),
                                Expanded(
                                    child: Container(
                                      height: Dimension.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: "\$ ${cartController.getItems[index]!.price!}",color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimension.height10,
                                                    bottom: Dimension.height10,
                                                    left: Dimension.width10,
                                                    right: Dimension.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimension.radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // popularProduct.setQuantity(false);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.sianColor,
                                                      ),
                                                    ),
                                                    SizedBox(width: Dimension.width10 / 2),
                                                    BigText(
                                                      text: "0",
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: Dimension.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          // popularProduct.setQuantity(true);
                                                        },
                                                        child: Icon(Icons.add, color: AppColors.sianColor))
                                                  ],
                                                ),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );
                        });
                  },),
                ),
              ))
        ],
      ),
    );
  }
}
