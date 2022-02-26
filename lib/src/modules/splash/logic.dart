import 'package:get/get.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SplashLogic extends GetxController {
  final PrefManger _prefManger = Get.put(PrefManger());

  void delay() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLogin = await _prefManger.getIsLogin();

    Get.offAndToNamed(isLogin ? '/home' : '/login');

  }
}
