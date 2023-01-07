import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommend_food_detail.dart';
import 'package:food_delivery_app/pages/home/main_food_home.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommended(int pageId) => '$recommendedFood?pageId=$pageId';

  static String getInitial() => '$initial';


  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => MainFoodHome(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(pageId : int.parse(pageId!));
        },
        // transition: Transition.fadeIn
    ),
  ];
}