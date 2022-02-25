import 'package:get/get.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/entities/about_us_response.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class AboutUsLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool isLoading = false;
  AboutUsResponse? aboutUsResponse;
  
  @override
  void onInit() {
    super.onInit();
    getAboutUs();
  }

  void getAboutUs() async {
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getAboutUs();

      aboutUsResponse = AboutUsResponse.fromJson(response.data);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
