import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sawa/src/modules/main/logic.dart';

import 'data/reomte/api_requests.dart';
import 'data/shared_preferences/pref_manger.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefManger>(() => PrefManger());
    Get.lazyPut<ApiRequests>(() => ApiRequests());
    Get.lazyPut<MainLogic>(() => MainLogic());
  }
}
