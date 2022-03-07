import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/entities/category_response.dart';
import 'package:sawa/src/entities/user_response.dart';
import 'package:sawa/src/modules/about_us/view.dart';
import 'package:sawa/src/modules/dilaogs/logout_dialog.dart';
import 'package:sawa/src/modules/instructions/view.dart';
import 'package:sawa/src/modules/map/view.dart';
import 'package:sawa/src/modules/splash/view.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.put(PrefManger());
  bool isLoading = false;
  bool isLogoutLoading = false;
  User? user;
  List<CategoryResponse> categoriesList = [];
  CategoryResponse? selected;

  @override
  void onInit() {
    if (!kIsWeb) getAccountDetails();
    if (!kIsWeb) getCategories();
    super.onInit();
  }

  void goToDoctor() async {
    bool isFirstTime = await _prefManger.getIsFirstTime();

    Get.toNamed(!isFirstTime ? '/rules' : '/doctor');
  }

  void getAccountDetails() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getAccountDetails();
      user = User.fromJson(response.data);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  void getCategories() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getCategories();
      categoriesList = (response.data as List)
          .map((e) => CategoryResponse.fromJson(e))
          .toList();
      selected = categoriesList.first;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  void setSelected(dynamic value) {
    selected = value;
    update();
  }

  void goToAbout() {
    Get.to(AboutUsPage());
  }

  goToCall(phoneNumber) async {
    String url = "tel://" + phoneNumber;
    await canLaunch(url) ? await launch(url) : log("message");
  }

  void goToMap([CategoryResponse? selected]) {
    Get.to(MapPage(
      categoryResponse: selected,
    ));
  }

  void goToLogoutDialog() {
    Get.dialog(LogoutDialog());
  }

  void goToMain() {
    log(Get.currentRoute);
    if (Get.currentRoute == "/home") {
      Get.back();
      return;
    }
    Get.back();
    Get.back();
  }

  void goToInstructions() {
    Get.to(() => InstructionsPage());
  }

  void goToSendReport() {
    if (kIsWeb) {
      Get.toNamed('/send-report/web');
      return;
    }
    var source = Platform.isIOS ? 'iOS' : 'Android';
    launch("https://ticket.sawa.ps/#/send-report/" + source,
        forceSafariVC: false);
  }

  void logout() async {

    await _prefManger.setIsLogin(false);
    await _prefManger.setIsFirstTime(false);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offAll(SplashPage());
  }

  Future<void> goToUrl() async {

    if (Platform.isAndroid) {
      await FlutterShare.share(
          title: 'Sawa 121',
          text: '',
          linkUrl: 'https://play.google.com/store/apps/details?id=com.mss.sawa',
          chooserTitle: 'Example Chooser Title');
    } else if (Platform.isIOS) {
      await FlutterShare.share(
          title: 'Sawa 121',
          text: '',
          linkUrl: 'https://apps.apple.com/il/app/sawa121/id1531265764',
          chooserTitle: 'Example Chooser Title');    }


  }
  /*
  goToUrl() async {
    goToSendReport();
    //await canLaunch("http://www.sawa121.org/") ? await launch("http://www.sawa121.org/") : log("message");
  }*/
}
