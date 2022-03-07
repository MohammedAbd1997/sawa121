import 'package:get/get.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class RulesLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  bool checked = false;
  bool isLoading = false;
  String rules = '';
  String rulesEn = '';

  void changeChecked(val) {
    checked = val;
    update();
  }

  void next() async {
    if (!await _prefManger.getIsLogin()) {
      Get.offNamed('/login');
      return;
    }
    if (checked) {
      await _prefManger.setIsFirstTime(true);
      Get.offNamed('/doctor');
    }
  }

  void getDoctorRules() async {
    if (!await _prefManger.getIsLogin()) {
      Get.offNamed('/login');
      return;
    }
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getDoctorRules();
      rules = response.data['content'];
      // log(instructions);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  void getDoctorRulesEn() async {
    if (!await _prefManger.getIsLogin()) {
      Get.offNamed('/login');
      return;
    }
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getDoctorRules();
      rulesEn = response.data['contentEn'];
      // log(instructions);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
