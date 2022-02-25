import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sawa/main.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/modules/dilaogs/success_send_report_dialog.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class SendReportLogic extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  bool isArabic = true;

  @override
  void onInit() async {
    super.onInit();
    isArabic = await PrefManger().getIsArabic();
    update();
  }

  bool isLoading = false;
  List list = ['تحرش جسدي', 'تحرش لفضي'];
  List contactList = ['واتساب'.tr, 'ماسنجر'.tr, 'رقم الهاتف'.tr, 'غير ذلك'.tr];
  String? selectedContact;
  String? source;
  int? selectedValue;
  String? date;
  DateTime? birthDay;
  TimeOfDay? timeOfDay;
  String? selected;

  changeLanguage(bool mIsArabic) async {
    await PrefManger().setIsArabic(mIsArabic);
    isArabic = mIsArabic;
    isArabicLanguage = mIsArabic;
    Get.updateLocale(Locale(isArabic ? 'ar' : 'en'));
    contactList = ['واتساب'.tr, 'ماسنجر'.tr, 'رقم الهاتف'.tr, 'غير ذلك'.tr];
    update();
  }

  void changeSelection(Object? value) {
    selectedValue = value as int;
    update();
  }

  String formatBirthDay() {
    return '${birthDay?.year}-${birthDay?.month}-${birthDay?.day}';
  }

  String formatTime() {
    return '${timeOfDay?.hour}:${timeOfDay?.minute}';
  }

  void setContactSelected(dynamic value) {
    selectedContact = value;
    update();
  }

  void setSelected(dynamic value) {
    selected = value;
    update();
  }

  sendReport() async {
    if (selectedContact == null) {
      Fluttertoast.showToast(
          msg: "يرجى تحديد ألية الاتصال".tr,
          webPosition: 'center',
          timeInSecForIosWeb: 2);
      return;
    }
    if (selectedValue == null) {
      Fluttertoast.showToast(
          msg: "يرجى تحديد حالة البلاغ".tr,
          webPosition: 'center',
          timeInSecForIosWeb: 2);
      return;
    }
    if (date == null) {
      Fluttertoast.showToast(
          msg: "يرجى تحديد الوقت المتاح للرجوع لك".tr,
          webPosition: 'center',
          timeInSecForIosWeb: 2);
      return;
    }
    isLoading = true;
    update();

    try {
      var res =
          await Dio(BaseOptions(baseUrl: 'https://sawa121.org/api/', headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        'accept': 'application/json',
      })).post('Tickets/Create', data: {
        "fullName": nameController.text,
        "phone": phoneController.text,
        "contactMethod": selectedContact,
        "contactValue": contactController.text,
        "ticketSource": source,
        "isUrgent": selectedValue == 1,
        "callBackTime": date,
      });
      nameController.text = '';
      phoneController.text = '';
      contactController.text = '';
      date = '';
      selectedContact = null;
      selectedValue = null;

      Get.toNamed('/home');
      Get.dialog(const SuccessSendReportDialog());
    } catch (e) {
      ErrorHandler.handleError(e, showToast: true);
    }
    isLoading = false;
    update();
  }
}
