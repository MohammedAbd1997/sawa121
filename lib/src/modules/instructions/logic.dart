import 'dart:developer';

import 'package:get/get.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class InstructionsLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;
  String instructions = '';
  String Eninstructions = '';


  void getInstructions() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getInstructions();
      instructions = response.data['content'];
      log(instructions);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
