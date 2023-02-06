import 'package:food_delivery_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/address_model.dart';
import '../api/api_client.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient , required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.get('/api/v1/config/geocode-api?lat=10.7723105&lng=106.6250295');
  }
  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }
  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.post(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }
  Future<Response> getAllAddress() async{
    return  await apiClient.get(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);
  }

  Future<Response> getZone(String lat , String lng ) async{
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

}