import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as ge;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';

class ApiRequests extends ge.GetxController {
  final PrefManger _prefManger = ge.Get.put(PrefManger());
  late Dio _dio;
  late Dio _dio1;

  @override
  Future<void> onInit() async {
    String token = await _prefManger.getToken();
    log(token);
    _dio = Dio(BaseOptions(baseUrl: 'https://sawa121.org/api/', headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    }));
    _dio1 = Dio(BaseOptions(baseUrl: 'https://83.244.113.154/api/', headers: {
      'accept': 'application/json',
      'content-type': 'application/json; charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
      // 'Authorization': 'Bearer $token'
    }));

/*    (_dio1.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };*/
    super.onInit();
  }

  Future<Response> socialLogin(String provider, String? accessToken) async {
    return await _dio.post('Users',
        data: {"provider": provider, "accessToken": accessToken});
  }

  Future<Response> getSliders() async {
    await onInit();
    return await _dio.get('Sliders');
  }

  Future<Response> getMapPoints() async {
    return await _dio.get('MapPoints');
  }

  Future<Response> getAccountDetails() async {
    await onInit();
    return await _dio.get('Users');
  }

  Future<Response> getAboutUs() async {
    return await _dio.get('AboutUs');
  }

  Future<Response> getCategories() async {
    await onInit();
    return await _dio.get('Report/categories');
  }

  Future<Response> getInstructions() async {
    return await _dio.get('Topics/3');
  }

  Future<Response> getDoctorRules() async {
    return await _dio.get('Topics/3');
  }

  Future<Response> getNotAvailable(String day) async {
    return await _dio
        .get('MedicalForms/not_avialible', queryParameters: {'day': day});
  }

  Future<Response> sendMedicalForm({
    String? fullName,
    bool? gender,
    String? telephone,
    String? yearOfBirth,
    bool? isSmoker,
    String? chronicDisease,
    bool? isPregnant,
    String? address,
    String? history,
    String? deviceType,
  }) async {
    log(deviceType.toString());
    return await _dio.post('MedicalForms', data: {
      "fullName": fullName,
      "gender": gender,
      "telephone": telephone,
      "yearOfBirth": yearOfBirth,
      "isSmoker": isSmoker,
      "chronicDisease": chronicDisease,
      "isPregnant": isPregnant,
      "address": address,
      "history": history,
      "deviceType": deviceType,
    });
  }

  Future<Response> getMedicalForm() async {
    return await _dio.get('MedicalForms');
  }

  Future<Response> editMedicalForm({
    String? fullName,
    bool? gender,
    String? telephone,
    String? yearOfBirth,
    bool? isSmoker,
    String? chronicDisease,
    bool? isPregnant,
    String? address,
    String? history,
  }) async {
    return await _dio.put('MedicalForms', data: {
      "fullName": fullName,
      "gender": gender,
      "telephone": telephone,
      "yearOfBirth": yearOfBirth,
      "isSmoker": isSmoker,
      "chronicDisease": chronicDisease,
      "isPregnant": isPregnant,
      "address": address,
      "history": history
    });
  }

  Future<Response> sendAppointment({
    String? time,
    String? day,
    bool? isVideo,
  }) async {
    var mDate = {
      "time": time,
      "day": day,
      "isVideo": isVideo,
    };
    log(mDate.toString());
    return await _dio.post('MedicalForms/booking', data: mDate);
  }

  Future<Response> getOtherBookings(String? day) async {
    var mDate = {
      "day": day,
    };
    log(mDate.toString());
    return await _dio.get('MedicalForms/booking', queryParameters: mDate);
  }

  Future<Response> getMyBookings(String? day) async {
    var mDate = {
      "day": day,
    };
    log(mDate.toString());
    return await _dio.get('MedicalForms/my_booking', queryParameters: mDate);
  }

  Future<Response> cancelAppointment({
    String? time,
    String? day,
  }) async {
    var mDate = {
      "time": time,
      "day": day,
    };
    log(mDate.toString());
    return await _dio.delete('MedicalForms/cancel', data: mDate);
  }

  Future<Response> sendReport({
    int? categoryId,
    LatLng? latLng,
  }) async {
    var mDate = {
      "categoryId": categoryId,
      "latitude": latLng?.latitude,
      "longitude": latLng?.longitude,
    };
    return await _dio.post('Report', data: mDate);
  }

  Future<Response> sendReportCallMeBack({
    String? fullName,
    String? phone,
    String? contactMethod,
    String? contactValue,
    String? ticketSource,
    bool? isUrgent,
    String? callBackTime,
  }) async {
    var mDate = {
      "fullName": fullName,
      "phone": phone,
      "contactMethod": contactMethod,
      "contactValue": contactValue,
      "ticketSource": ticketSource,
      "isUrgent": isUrgent,
      "callBackTime": callBackTime,
    };
    return await _dio.post('Tickets/Create', data: mDate);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
