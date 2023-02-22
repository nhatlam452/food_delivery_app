import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/model/order_model.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          late List<OrderModel> orderModelList;
          if (orderController.currentOrderList.isNotEmpty) {
            orderModelList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimension.screenWidth,
            child: Padding(
              padding: EdgeInsets.all(Dimension.width10),
              child: ListView.builder(
                  itemCount: orderModelList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => null,
                      child: Column(
                        children: [
                          Container(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("#order id          " +
                                      orderModelList[index].id.toString()),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius20 / 4)),
                                          child: Container(
                                              margin: EdgeInsets.all(
                                                  Dimension.height10 / 2),
                                              child: Text(
                                                "${orderModelList[index].orderStatus}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))),
                                      SizedBox(
                                        height: Dimension.height10 / 2,
                                      ),
                                      InkWell(
                                        onTap: () => null,
                                        child: Container(
                                          child: Text("Track Order"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                          SizedBox(
                            height: Dimension.height10,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else {
          return Text("loading");
        }
      }),
    );
  }
}
