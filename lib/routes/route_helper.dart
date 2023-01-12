import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommend_food_detail.dart';
import 'package:food_delivery_app/pages/home/main_food_home.dart';
import 'package:food_delivery_app/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage ="/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';

  static String getRecommended(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';

  static String getSplashPage() => '$splashPage';

  static String getInitial() => '$initial';

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => SplashPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () => HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page : page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return RecommendedFoodDetail(pageId: int.parse(pageId!),page : page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
