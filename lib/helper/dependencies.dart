import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommend_product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/response/cart_repo.dart';
import 'package:food_delivery_app/data/response/popular_product_repo.dart';
import 'package:food_delivery_app/data/response/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //repo
  Get.lazyPut(() => PopularProductResponse(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductResponse(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  //controller
  Get.lazyPut(
      () => PopularProductController(popularProductResponse: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductResponse: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
