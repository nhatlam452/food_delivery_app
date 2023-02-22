import 'dart:convert';

import 'package:food_delivery_app/model/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/response/location_repo.dart';
import 'package:geolocator/geolocator.dart';

import '../model/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  late LatLng _currentLatlng;

  LatLng get currentLatLng => _currentLatlng;

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark => _placemark;

  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;

  List<AddressModel> get allAddressList => _allAddressList;

  final List<String> _addressTypeList = ["home", "office", "others"];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;

  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;
  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;

  Position get position => _position;

  Position get pickPosition => _pickPosition;

  bool _isLoading = false; //for zone service
  bool get isLoading => _isLoading;

  bool _inZone = false; //check if user in service zone
  bool get inZone => _inZone;
  bool _buttonDisable = true;

  bool get buttonDisable => _buttonDisable;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              latitude: cameraPosition.target.latitude,
              longitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        } else {
          _pickPosition = Position(
              latitude: cameraPosition.target.latitude,
              longitude: cameraPosition.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        }

        ResponseModel _responseModel = await getZone(
            cameraPosition.target.latitude.toString(),
            cameraPosition.target.longitude.toString(),
            false);
        /*
        if btn value is false we are in service area
        */
        _buttonDisable = !_responseModel.isSuccess;
        if (_changeAddress) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              cameraPosition.target.latitude, cameraPosition.target.longitude);
          Placemark placemark = placemarks.first;
          String _fullAddressLine =
              "${placemark.subThoroughfare},${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}";
          fromAddress
              ? _placemark = Placemark(name: _fullAddressLine)
              : _pickPlacemark = Placemark(name: _fullAddressLine);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }



  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response reponse = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (reponse.statusCode == 200) {
      String msg = reponse.body["message"];
      responseModel = ResponseModel(true, msg);
      saveUserAddress(addressModel);
    } else {
      print("couldn't save the addresss");
      responseModel = ResponseModel(false, reponse.statusText!);
    }
    update();
    return responseModel;
  }

// Future<String> getAddressFromGeoCode(LatLng latLng) async {
//   print("lat funtion : " +
//       latLng.latitude.toString() +
//       "long : " +
//       latLng.longitude.toString());
//   String _address = "Unknown location found";
//   Response response = await locationRepo.getAddressFromGeocode(latLng);
//   if (response.body['status'] == 'OK') {
//     print("alo");
//     _address = response.body['results'][0]['formatted_address'].toString();
//     print('Address : ' + _address);
//   } else {
//     print("Google Api error");
//   }
//   return _address;
// }
  getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      (jsonDecode(response.body) as List).forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    print("list size : " + _addressList.length.toString());
    update();
  }

  getCurrentLocation() async {
    LatLng latLng = await locationRepo.getCurrentLocation();
    _currentLatlng = latLng;
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  String getUserAddressFronLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    print(response.statusCode);
    update();

    return _responseModel;
  }
}
