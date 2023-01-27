import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:get/get.dart';

class PopularProductResponse extends GetxService{
  final ApiClient apiClient;


  PopularProductResponse({required this.apiClient});

  Future<Response> getPopularProductList() async
  {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);

  }  
}