import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/util/colors.dart';
import 'package:food_delivery_app/util/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/custom_button.dart';
import '../../controllers/location_controller.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosition = LatLng(10.7723105, 106.6250295);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initalPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                      print("in zone : " +
                          locationController.inZone.toString() +
                          " - from address" +
                          widget.fromAddress.toString());
                      print("latitude : " +
                          locationController.pickPosition.latitude.toString() +
                          " - from address" +
                          locationController.pickPosition.longitude.toString());
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                      child: !locationController.loading
                          ? Image.asset(
                              "assets/image/map_picker.png",
                              height: 50,
                              width: 50,
                            )
                          : CircularProgressIndicator()),
                  Positioned(
                      top: Dimension.height45,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimension.width10),
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20 / 2)),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 25, color: Colors.white),
                            Expanded(
                                child: Text(
                              '${locationController.pickPlacemark.name ?? ""}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimension.font16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 80,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child: locationController.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(
                              buttonText: widget.fromAddress
                                  ? 'Pick Address'
                                  : 'Pick Location',
                              onPressed: (locationController.buttonDisable ||
                                      locationController.loading)
                                  ? null
                                  : () {
                                      if (locationController
                                                  .pickPosition.latitude !=
                                              0 &&
                                          locationController
                                                  .pickPlacemark.name !=
                                              null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController !=
                                              null) {
                                            widget.googleMapController!
                                                .moveCamera(CameraUpdate
                                                    .newCameraPosition(
                                                        CameraPosition(
                                                            target: LatLng(
                                              locationController
                                                  .pickPosition.latitude,
                                              locationController
                                                  .pickPosition.longitude,
                                            ))));
                                            locationController.setAddressData();
                                          }
                                          //Get back create update problem

                                          Get.back(result:  '${locationController.pickPlacemark.name ?? ""}');
                                        }
                                      }
                                    },
                            ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
