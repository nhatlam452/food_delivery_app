import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/order_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommend_product_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/response/OrderRepo.dart';
import 'package:food_delivery_app/data/response/auth_repo.dart';
import 'package:food_delivery_app/data/response/cart_repo.dart';
import 'package:food_delivery_app/data/response/location_repo.dart';
import 'package:food_delivery_app/data/response/popular_product_repo.dart';
import 'package:food_delivery_app/data/response/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/response/user_repo.dart';
import '../util/app_constants.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences : Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));  Get.lazyPut(
      () => UserRepo(apiClient: Get.find()));
  //repo
  Get.lazyPut(() => PopularProductResponse(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductResponse(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(
      () => PopularProductController(popularProductResponse: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductResponse: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo :Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
