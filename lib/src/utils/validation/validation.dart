
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Validation {

  static String? commentValidate(val) {
    return val!.isEmpty ? "Commentـrequired".tr() : null;
  }

  static String? nameValidate(val) {
    return val!.isEmpty ? "Full_required".tr() : null;
  }

  static String? emailValidate(val) {
    return val!.isEmpty
        ? "Email_required".tr()
        : !GetUtils.isEmail(val)
            ? "Invalid_email".tr()
            : null;
  }

  static String? whatsappValidate(val) {
    return val!.isEmpty
        ? "WhatsApp_required".tr()
        : val.length != 12
            ? "The_number_digits".tr()
            : null;
  }
  static String? phoneValidate(val) {
    return val!.isEmpty
        ? "Phone_required".tr()
        : val.length != 10
            ? "The_digits".tr()
            : null;
  }

  static String? passwordValidate(val) {
    return val!.isEmpty ? "Password_required".tr() : null;
  }
  static String? filedValidate(val) {
    return val!.isEmpty ? "This_required".tr() : null;
  }

}
