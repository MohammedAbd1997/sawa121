import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/entities/slider_response.dart';
import 'package:sawa/src/modules/main/view.dart';
import 'package:sawa/src/utils/custom_widget/custom_indicator.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

import '../../binding.dart';

class OnBoardingLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  bool isLoading = false;

  List<SliderResponse> onBList = [];

  int currentPage = 0;
  bool isInWishlist = false;
  bool isEnable = false;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit()  {
    super.onInit();
    getSliders();
  }
  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < onBList.length; i++) {
      list.add(i == currentPage
          ? const CustomIndicator(true)
          : const CustomIndicator(false));
    }
    return list;
  }

  void goToMainPage(){
    Get.offNamed('/home');
  }

  void getSliders() async {
    if(!await _prefManger.getIsLogin()){
      Get.offNamed('/login');
      return;
    }
    isLoading = true;
    update();
    try{
      var response = await _apiRequests.getSliders();
      onBList = (response.data as List)
          .map((x) => SliderResponse.fromJson(x))
          .toList();

    }catch (e){
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
