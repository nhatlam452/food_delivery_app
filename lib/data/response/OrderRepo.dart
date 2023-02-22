import 'package:food_delivery_app/model/place_order_model.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI , placeOrderBody.toJson());
  }

  Future<Response> getOrderList() async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}
