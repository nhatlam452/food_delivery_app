import "package:flutter/material.dart";
import "package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart";
import "package:food_delivery_app/base/custom_radio_button.dart";
import "package:food_delivery_app/controllers/location_controller.dart";
import "package:food_delivery_app/model/order_model.dart";
import "package:food_delivery_app/model/place_order_model.dart";
import "package:food_delivery_app/util/colors.dart";
import "package:geocoding/geocoding.dart";
import "package:get/get.dart";
import "../../base/custom_loader.dart";
import "../../controllers/cart_controller.dart";
import "../../controllers/order_controller.dart";
import "../../controllers/user_controller.dart";
import "../../routes/route_helper.dart";
import "../../util/app_constants.dart";
import "../../util/dimensions.dart";
import "../../widgets/app_text_field.dart";
import "../../widgets/big_text.dart";
import "../../widgets/small_text.dart";
import "../address/pick_address_map.dart";

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _address = '';
  late String selectedUrl;
  String _selectedOption = 'Pay by Zalo Pay';
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  void _handleRadioValueChanged(String? value) {
    setState(() {
      _selectedOption = value!;
    });
  }

  getCurrentLocation() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          Get.find<LocationController>().currentLatLng.latitude,
          Get.find<LocationController>().currentLatLng.longitude);
      Placemark placemark = placemarks[0];
      setState(() {
        _address =
            "${placemark.subThoroughfare},${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}";
        ;
        _addressController.text = _address;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<UserController>().getUserInfo();
    Get.find<LocationController>().getCurrentLocation();
    getCurrentLocation();
    selectedUrl = "";
    // '${AppConstants.BASE_URL}/payment-mobile?customer_id=${}&order_id=${}';
  }

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartData().reversed.toList();
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

    List<int> itemPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Payment")),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: Dimension.height30 * 4,
                  child: Column(
                    children: [
                      BigText(text: "Your Item(s)"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimension.height10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children:
                                    List.generate(itemPerOrder[0], (index) {
                                  if (listCounter < getCartHistoryList.length) {
                                    listCounter++;
                                  }
                                  return index <= 2
                                      ? Container(
                                          height: Dimension.height20 * 4,
                                          width: Dimension.height20 * 4,
                                          margin: EdgeInsets.only(
                                              right: Dimension.width10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius20 / 2.5),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(
                                      text: "Total",
                                      color: Colors.black54,
                                    ),
                                    BigText(
                                      text: itemPerOrder[0].toString() +
                                          " Item(s)",
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                      top: Dimension.height20,
                      left: Dimension.width20,
                      right: Dimension.width20),
                ),
                SizedBox(
                  height: Dimension.height20,
                ),
                GetBuilder<UserController>(builder: (userController) {
                  if (userController.userModel != null &&
                      _contactPersonName.text.isEmpty) {
                    _contactPersonName.text =
                        '${userController.userModel?.name}';
                    _contactPersonNumber.text =
                        '${userController.userModel.phone}';
                  }
                  return userController.isLoading
                      ? Container(
                          child: Column(
                            children: [
                              BigText(text: "Delivery Info"),
                              SizedBox(
                                height: Dimension.height10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                        textEditingController:
                                            _addressController,
                                        hintText: "Your Address",
                                        icon: Icons.map),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteHelper.getPickAddress(),
                                        arguments: PickAddressMap(
                                          fromSignup: false,
                                          fromAddress: true,
                                        ),
                                      )!
                                          .then((value) => _addressController
                                                  .text =
                                              value ?? _addressController.text);
                                    },
                                    child: Image.asset(
                                      "assets/image/gg_map.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimension.height20,
                              ),
                              AppTextField(
                                  textEditingController: _contactPersonName,
                                  hintText: "Your name",
                                  icon: Icons.person),
                              SizedBox(
                                height: Dimension.height20,
                              ),
                              AppTextField(
                                  textEditingController: _contactPersonNumber,
                                  hintText: "Your phone",
                                  icon: Icons.phone),
                              SizedBox(
                                height: Dimension.height20,
                              ),
                            ],
                          ),
                        )
                      : CustomLoader();
                }),
                Container(
                  child: Column(
                    children: [
                      BigText(text: "Payment Method"),
                      Row(
                        children: [
                          CustomRadioButton(
                            image: 'assets/image/zalo_pay.png',
                            title: 'Pay by Zalo Pay',
                            value: 'Pay by Zalo Pay',
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChanged,
                          ),
                          CustomRadioButton(
                            image: 'assets/image/ship_cod.jpg',
                            title: 'Ship COD',
                            value: 'Ship COD',
                            groupValue: _selectedOption,
                            onChanged: _handleRadioValueChanged,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cart) {
          return Container(
            height: Dimension.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height30,
                left: Dimension.width20,
                right: Dimension.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20 * 2),
                  topRight: Radius.circular(Dimension.radius20 * 2),
                )),
            child: cart.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimension.height20,
                            bottom: Dimension.height20,
                            left: Dimension.width20,
                            right: Dimension.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            SizedBox(width: Dimension.width10 / 2),
                            BigText(
                              text: "\$ " + cart.totalAmount.toString(),
                              color: Colors.black,
                              size: Dimension.iconSize16,
                            ),
                            SizedBox(
                              width: Dimension.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                          var location = _addressController.text;
                          var cart = Get.find<CartController>().getItems;
                          var user = Get.find<UserController>().userModel;
                          PlaceOrderBody placeOrderBody = PlaceOrderBody(
                              cart: cart,
                              orderAmount: 100.0,
                              orderNote: "Not about the food",
                              address: location,
                              latitude: "",
                              longitude: " ",
                              contactPersonName: user!.name,
                              contactPersonNumber: user!.phone,
                              scheduleAt: "",
                              distance: 10.0);
                          Get.find<OrderController>()
                              .placeOrder(placeOrderBody);
                          Get.find<CartController>().addToHistory();
                          Get.offNamed(RouteHelper.getInitial());
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              left: Dimension.width20,
                              right: Dimension.width20),
                          child: BigText(
                            text: "Check out",
                            color: Colors.white,
                            size: Dimension.iconSize16,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                              color: AppColors.mainColor),
                        ),
                      )
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
