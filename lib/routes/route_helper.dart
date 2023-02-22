import 'package:food_delivery_app/model/order_model.dart';
import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/address/pick_address_map.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommend_food_detail.dart';
import 'package:food_delivery_app/pages/home/main_food_home.dart';
import 'package:food_delivery_app/pages/payment/payment_page.dart';
import 'package:food_delivery_app/splash/splash_page.dart';
import 'package:get/get.dart';

import '../auth/sign_in_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/sign-in-page";
  static const String addAddress = "/add-address-page";
  static const String pickAddress = "/pick-address-page";
  static const String paymentPage = "/payment-page";
  static const String orderSuccess = "/order-success";

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommended(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';

  static String getPaymentPage() => '$paymentPage';

  static String getSignInPage() => '$signInPage';

  static String getSplashPage() => '$splashPage';

  static String getInitial() => '$initial';

  static String getAddAddress() => '$addAddress';

  static String getPickAddress() => '$pickAddress';
  static String getOrderSuccess(String orderID , String status) => '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => SplashPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: initial, page: () => HomePage(), transition: Transition.fadeIn),
    GetPage(
        name: signInPage,
        page: () => SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: paymentPage,
        page: () {
          return PaymentPage(


          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pickAddress,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        },
        transition: Transition.fadeIn),
    // GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
    //   orderID : Get.parameters['id'], status : Get.parameters['status'].toString().contains("success")?1:0,
    // ))
  ];
}
