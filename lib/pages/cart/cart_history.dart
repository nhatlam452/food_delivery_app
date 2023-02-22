import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../util/colors.dart';
import '../../widgets/big_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var date = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var format = DateFormat("dd/MM/yyyy hh:mm a");
        date = format.format(parseDate);
      }


      return BigText(
        text: date,
        color: Colors.black,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimension.height10 * 10,
            padding: EdgeInsets.only(top: Dimension.height45),
            width: double.maxFinite,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                Icon(
                  CupertinoIcons.shopping_cart,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: Dimension.height10 * 50,
              margin: EdgeInsets.only(
                  top: Dimension.height20,
                  left: Dimension.width20,
                  right: Dimension.width20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: itemPerOrder.length > 0
                    ? ListView(
                        children: [
                          for (int i = 0; i < itemPerOrder.length; i++)
                            Container(
                              height: Dimension.height30 * 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(
                                    height: Dimension.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemPerOrder[i],
                                            (index) {
                                          if (listCounter <
                                              getCartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                                  height:
                                                      Dimension.height20 * 4,
                                                  width: Dimension.height20 * 4,
                                                  margin: EdgeInsets.only(
                                                      right: Dimension.width10 /
                                                          2),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimension
                                                                  .radius20 /
                                                              2.5),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              AppConstants
                                                                      .BASE_URL +
                                                                  "/uploads/" +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!))),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      Container(
                                        height: Dimension.height20 * 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(
                                              text: "Total",
                                              color: Colors.black54,
                                            ),
                                            BigText(
                                              text: itemPerOrder[i].toString() +
                                                  " Item(s)",
                                              color: Colors.black,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                var orderTime =
                                                    cartOrderTimeToList();
                                                Map<int, CartModel> moreOrder =
                                                    {};
                                                for (int j = 0;
                                                    j <
                                                        getCartHistoryList
                                                            .length;
                                                    j++) {
                                                  if (getCartHistoryList[j]
                                                          .time ==
                                                      orderTime[i]) {
                                                    moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () => CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                getCartHistoryList[
                                                                    j]))));
                                                  }
                                                }
                                                Get.find<CartController>()
                                                    .setItems = moreOrder;
                                                Get.find<CartController>()
                                                    .addToCartList();
                                                Get.toNamed(
                                                    RouteHelper.getCartPage());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimension.width10,
                                                    vertical:
                                                        Dimension.height10 / 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimension.radius20 /
                                                                4),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor)),
                                                child: SmallText(
                                                    text: "Order again",
                                                    color: AppColors.mainColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              margin:
                                  EdgeInsets.only(bottom: Dimension.height20),
                            )
                        ],
                      )
                    : NoDataPage(
                        text: "You don't have any order",
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
