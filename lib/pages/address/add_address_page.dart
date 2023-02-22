import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/model/address_model.dart';
import 'package:food_delivery_app/pages/address/pick_address_map.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(10.7723105, 106.6250295), zoom: 17);
  late LatLng _initialPosition = LatLng(10.7723105, 106.6250295);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<LocationController>().getAddressList();
    print("is Empty : " +
        Get.find<LocationController>().addressList.isEmpty.toString());
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFronLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Address"),
        backgroundColor: AppColors.mainColor,
      ),
      body: Center(
        child: GetBuilder<UserController>(builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 148,
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimension.radius30 / 2),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddress(),
                                  arguments: PickAddressMap(
                                    fromSignup: false,
                                    fromAddress: true,
                                    googleMapController:
                                        locationController.mapController,
                                  ));
                            },
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: true,
                            indoorViewEnabled: true,
                            myLocationEnabled: true,
                            mapToolbarEnabled: false,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height: Dimension.height20 * 2.5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: Dimension.width20,
                                    top: Dimension.height20),
                                child: InkWell(
                                    onTap: () {
                                      locationController
                                          .setAddressTypeIndex(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimension.width20,
                                          vertical: Dimension.height10),
                                      margin: EdgeInsets.only(
                                          right: Dimension.width10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimension.radius20 / 4),
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ]),
                                      child: Row(
                                        children: [
                                          Icon(
                                            index == 0
                                                ? Icons.home_filled
                                                : index == 1
                                                    ? Icons.work
                                                    : Icons.location_on,
                                            color: locationController
                                                        .addressTypeIndex ==
                                                    index
                                                ? AppColors.mainColor
                                                : Theme.of(context)
                                                    .disabledColor,
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            })),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width20),
                      child: BigText(
                        text: "Delivery Info",
                      ),
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        textEditingController: _addressController,
                        hintText: "Your Address",
                        icon: Icons.map),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        textEditingController: _contactPersonName,
                        hintText: "Your name",
                        icon: Icons.person),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    AppTextField(
                        textEditingController: _contactPersonNumber,
                        hintText: "Your phone",
                        icon: Icons.phone),
                  ],
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimension.bottomHeightBar,
                padding: EdgeInsets.only(
                    top: Dimension.height30,
                    bottom: Dimension.height30,
                    left: Dimension.width20,
                    right: Dimension.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20 * 2),
                      topRight: Radius.circular(Dimension.radius20 * 2),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressNodel = AddressModel(
                            addressType: locationController.addressTypeList[
                                locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            latitude: locationController.position.latitude
                                    .toString() ??
                                '',
                            longitude: locationController.position.longitude
                                    .toString() ??
                                '',
                            address: _addressController.text);
                        locationController
                            .addAddress(_addressNodel)
                            .then((response) {
                          if (response.isSuccess) {
                            Get.back();
                            Get.snackbar("Address", "Added Successfully");
                          } else {
                            Get.snackbar("Address", "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                        height: Dimension.height20 * 8,
                        padding: EdgeInsets.only(
                            top: Dimension.height20,
                            bottom: Dimension.height20,
                            left: Dimension.width20,
                            right: Dimension.width20),
                        child: BigText(
                          text: "Save Address",
                          color: Colors.white,
                          size: Dimension.font16 * 1.5,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
