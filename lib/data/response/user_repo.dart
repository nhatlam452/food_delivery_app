import 'package:food_delivery_app/model/response_model.dart';
import 'package:food_delivery_app/util/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async{
    return await apiClient.getData(AppConstants.USER_INFO);
  }

}