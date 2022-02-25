import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorHandler {
  static handleError(Object e ,{bool? showToast}){
    if (e is DioError) {
      if (e.response != null && showToast == true) {
        try{
          Fluttertoast.showToast(msg: e.response!.data['errors']['msg'].toString());
        }catch(ee){
          Fluttertoast.showToast(msg: e.response!.data.toString());
        }
        log(e.response!.data.toString());

      }
      log(e.message.toString());

    }else{
      log(e.toString());
    }
  }
}