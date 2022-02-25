import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/entities/category_response.dart';
import 'package:sawa/src/entities/map_point_model.dart';
import 'package:sawa/src/modules/dilaogs/success_send_report_dialog.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class MapLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;
  List<MapPointModel> mapPointModelList = [];

  ClusterManager? manager;
  final Completer<GoogleMapController> controller = Completer();
  Set<Marker> myMarkers = {};
  Set<Marker> markers = {};
  LatLng? selectedLatLng;
  final CameraPosition palestineCameraPosition =
      const CameraPosition(target: LatLng(31.794574, 35.187335), zoom: 8.0);
  List<Place> items = [];
  CategoryResponse? categoryResponse;
  GoogleMapController? googleMapController;

  MapLogic(this.categoryResponse);

  @override
  void onInit() async {
    if (categoryResponse == null) {
      await getMapPoints();
      manager = _initClusterManager();
    }
    super.onInit();
  }

  Future<Position> determinePosition(
      GoogleMapController _googleMapController) async {
    googleMapController = _googleMapController;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    selectedLatLng = LatLng(position.latitude, position.longitude);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: selectedLatLng!,
            zoom: 14.0)));
    myMarkers = <Marker>{};
    myMarkers.add(Marker(
        markerId: MarkerId("my marker"),
        position: selectedLatLng!));
    update();
    return position;
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    this.markers = markers;
    update();
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<void> getMapPoints() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getMapPoints();
      mapPointModelList = (response.data as List)
          .map((x) => MapPointModel.fromJson(x))
          .toList();

      mapPointModelList.forEach((element) {
        items.add(Place(
            name: "", latLng: LatLng(element.latitude!, element.longitude!)));
      });

      manager = _initClusterManager();
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  onTap(LatLng mLatLag) {
    selectedLatLng = mLatLag;
    log(mLatLag.toString());
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: mLatLag, zoom: 14.0)));
    myMarkers = <Marker>{};
    myMarkers.add(Marker(markerId: const MarkerId("my marker 2"), position: mLatLag));
    update();
  }

  sendReport() async {
    isLoading = true;
    update();
    try {
      var res = await _apiRequests.sendReport(
        categoryId: categoryResponse?.id,
        latLng: selectedLatLng
      );

      Get.back();
      Get.dialog(const SuccessSendReportDialog());
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}

class Place with ClusterItem {
  final String name;
  final LatLng latLng;

  Place({required this.name, required this.latLng});

  @override
  LatLng get location => latLng;
}
