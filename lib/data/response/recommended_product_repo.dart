import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductResponse extends GetxService{
  final ApiClient apiClient;


  RecommendedProductResponse({required this.apiClient});

  Future<Response> getRecommendedProductList() async
  {
    return await apiClient.getData(AppConstants.RECOMMEND_PRODUCT_URI);
  }
}