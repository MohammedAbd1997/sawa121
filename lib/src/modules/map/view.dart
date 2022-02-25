import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawa/src/entities/category_response.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';

import 'logic.dart';

class MapPage extends StatelessWidget {
  CategoryResponse? categoryResponse;

  MapPage({this.categoryResponse, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLogic>(
        init: Get.put(MapLogic(categoryResponse)),
        builder: (logic) {
          return Scaffold(
            body: (logic.isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            categoryResponse == null
                                ? GoogleMap(
                                    zoomControlsEnabled: true,
                                    zoomGesturesEnabled: true,
                                    initialCameraPosition:
                                        logic.palestineCameraPosition,
                                    markers: logic.markers,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      if (!logic.controller.isCompleted) {
                                        logic.controller.complete(controller);
                                      }
                                      logic.manager?.setMapId(controller.mapId);
                                    },
                                    onCameraMove: logic.manager?.onCameraMove,
                                    onCameraIdle: logic.manager?.updateMap)
                                : GoogleMap(
                                    zoomControlsEnabled: true,
                                    zoomGesturesEnabled: true,
                                    onTap: (latLng) => logic.onTap(latLng),
                                    initialCameraPosition: logic.palestineCameraPosition,
                                    markers: logic.myMarkers,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      logic.determinePosition(controller);
                                      if (!logic.controller.isCompleted) {
                                        logic.controller.complete(controller);
                                      }
                                    },
                                  ),
                            Positioned(
                              top: 50,
                              left: 20,
                              right: 20,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.arrow_back_ios)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: categoryResponse != null,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButtonWidget(
                                title: "send_report".tr(),
                                width: Get.width * 0.8,
                                textSize: 16,
                                onClick: () => logic.sendReport()),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
