import 'package:get/get.dart';

class Validation {

  static String? commentValidate(val) {
    return val!.isEmpty ? 'التعليق مطلوب'.tr : null;
  }

  static String? nameValidate(val) {
    return val!.isEmpty ? 'الاسم الكامل مطلوب'.tr : null;
  }

  static String? emailValidate(val) {
    return val!.isEmpty
        ? 'البريد الإلكتروني مطلوب'.tr
        : !GetUtils.isEmail(val)
            ? "البريد الالكتروني غير صالح".tr
            : null;
  }

  static String? whatsappValidate(val) {
    return val!.isEmpty
        ? 'رقم الواتساب مطلوب'.tr
        : val.length != 12
            ? "يجب ان يكون الرقم عن 12 أرقام".tr
            : null;
  }
  static String? phoneValidate(val) {
    return val!.isEmpty
        ? 'رقم الهاتف مطلوب'.tr
        : val.length != 10
            ? "يجب ان يكون الرقم عن 10 أرقام".tr
            : null;
  }

  static String? passwordValidate(val) {
    return val!.isEmpty ? 'كلمة المرور مطلوبة'.tr : null;
  }
  static String? filedValidate(val) {
    return val!.isEmpty ? 'هذا الحقل مطلوب'.tr : null;
  }

}
