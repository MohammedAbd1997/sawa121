import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sawa/src/data/reomte/api_requests.dart';
import 'package:sawa/src/data/shared_preferences/pref_manger.dart';
import 'package:sawa/src/entities/appointment_model.dart';
import 'package:sawa/src/entities/day_model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:sawa/src/entities/day_response.dart';
import 'package:sawa/src/entities/medical_form_response.dart';
import 'package:sawa/src/modules/dilaogs/delete_appointment_dialog.dart';
import 'package:sawa/src/modules/dilaogs/success_dialog.dart';
import 'package:sawa/src/utils/error_handler/error_handler.dart';

class DoctorLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  bool isLoading = false;
  bool isAppointmentLoading = false;
  bool isSendFormLoading = false;
  bool firstTime = true;
  DateTime? birthDay;
  MedicalFormResponse? medicalFormResponse;
  int selectedSixValue = 0;
  int selectedSocialStatusValue = 0;
  int selectedValue = 0;
  int selectedDay = 0;
  int? selectedAppointment;
  int selectedTypeValue = 0;
  int selectedSmokeValue = 0;

  bool bloodPressure = false;
  bool drunken = false;
  bool sensitive = false;
  bool heartDisease = false;
  List<DayResponse> notAvailableDaysList = [];
  List<DayResponse> myBookingsDaysList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String formatBirthDay() {
    return '${birthDay?.year}-${birthDay?.month}-${birthDay?.day}';
  }

  void changeSixSelection(Object? value) {
    selectedSixValue = value as int;
    if (selectedSixValue == 1) {
      selectedValue = 0;
    }
    update();
  }

  void changeSelection(Object? value) {
    if (selectedSixValue == 2) {
      selectedValue = value as int;
    }
    update();
  }

  void changeSocialStatusSelection(Object? value) {
    selectedSocialStatusValue = value as int;
    update();
  }

  void changeSmokeSelection(Object? value) {
    selectedSmokeValue = value as int;
    update();
  }

  void changeTypeSelection(Object? value) {
    selectedTypeValue = value as int;
    update();
  }

  void changeDaySelection(int index) {
    selectedDay = index;
    getNotAvailable(index);
    update();
  }

  changeDisease(val, index) {
    if (index == 0) {
      bloodPressure = val;
    } else if (index == 1) {
      drunken = val;
    } else if (index == 2) {
      sensitive = val;
    } else if (index == 3) {
      heartDisease = val;
    }
    update();
  }

  changeFirstTimeValue(bool bool) {
    firstTime = bool;
    update();
  }

  selectAppointment(int index) {
    selectedAppointment = index;
    update();
  }

  void openCancelDialog(int index) {
    Get.dialog(DeleteAppointmentDialog(index));
  }

  void getMedicalForm() async {
    if (!await _prefManger.getIsLogin()) {
      Get.offNamed('/login');
      return;
    }
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.getMedicalForm();
      medicalFormResponse = MedicalFormResponse.fromJson(response.data);

      firstTime = false;

      if (medicalFormResponse != null) {
        nameController =
            TextEditingController(text: medicalFormResponse!.fullName);
        phoneController =
            TextEditingController(text: medicalFormResponse!.telephone);
        addressController =
            TextEditingController(text: medicalFormResponse!.address);
        medicalFormResponse!.gender!
            ? selectedSixValue = 1
            : selectedSixValue = 2;
        medicalFormResponse!.isPregnant!
            ? selectedValue = 3
            : selectedSixValue = 4;
        medicalFormResponse!.isSmoker!
            ? selectedSmokeValue = 3
            : selectedSmokeValue = 4;

        if (medicalFormResponse!.history!.contains("Married".tr()))
          selectedSocialStatusValue = 1;
        if (medicalFormResponse!.history!.contains("single".tr()))
          selectedSocialStatusValue = 2;
        if (medicalFormResponse!.history!.contains("Divorced".tr()))
          selectedSocialStatusValue = 3;
        if (medicalFormResponse!.history!.contains("Widower".tr()))
          selectedSocialStatusValue = 4;

        //birthDay =
      }

      log(response.data.toString());
    } catch (e) {
      firstTime = true;
      // ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  void getNotAvailable(int index) async {
    if (!await _prefManger.getIsLogin()) {
      //  Get.offNamed('/login');
      return;
    }
    appointmentsList = [
      AppointmentModel(true, false, '09:00 _ 09:30'),
      AppointmentModel(true, false, '09:30 _ 10:00'),
      AppointmentModel(true, false, '10:00 _ 10:30'),
      AppointmentModel(true, false, '10:30 _ 11:00'),
      AppointmentModel(true, false, '11:00 _ 11:30'),
      AppointmentModel(true, false, '11:30 _ 12:00'),
      AppointmentModel(true, false, '12:00 _ 12:30'),
      AppointmentModel(true, false, '12:30 _ 01:00'),
      AppointmentModel(true, false, '01:00 _ 01:30'),
      AppointmentModel(true, false, '01:30 _ 02:00'),
      AppointmentModel(true, false, '02:00 _ 02:30'),
      AppointmentModel(true, false, '02:30 _ 03:00'),
      AppointmentModel(true, false, '03:00 _ 03:30'),
      AppointmentModel(true, false, '03:30 _ 04:00'),
      AppointmentModel(true, false, '04:00 _ 04:30'),
      AppointmentModel(true, false, '04:30 _ 05:00'),
      AppointmentModel(true, false, '05:00 _ 05:30'),
      AppointmentModel(true, false, '05:30 _ 06:00'),
      AppointmentModel(true, false, '06:00 _ 06:30'),
      AppointmentModel(true, false, '06:30 _ 07:00'),
      AppointmentModel(true, false, '07:00 _ 07:30'),
      AppointmentModel(true, false, '07:30 _ 08:00'),
      AppointmentModel(true, false, '08:00 _ 08:30'),
      AppointmentModel(true, false, '08:30 _ 09:00'),
      AppointmentModel(true, false, '09:00 _ 09:30'),
      AppointmentModel(true, false, '09:30 _ 10:00'),
    ];
    isAppointmentLoading = true;
    update();
    try {
      var dateDay = DateTime.now().add(Duration(days: index));
      String day = dateDay.year.toString() +
          "-" +
          dateDay.month.toString() +
          "-" +
          dateDay.day.toString();
      // log(day);
      var response = await _apiRequests.getNotAvailable(day);
      notAvailableDaysList =
          (response.data as List).map((x) => DayResponse.fromJson(x)).toList();

      notAvailableDaysList.forEach((notAvailableElement) {
        appointmentsList.forEach((element) {
          if (element.title.startsWith(notAvailableElement.time!)) {
            element.isAvailable = false;
            log(element.title);
          }
        });
      });
      getMyBooking(index);
      getOtherBooking(index);

      log(response.data.toString());
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isAppointmentLoading = false;
    update();
  }

  void getMyBooking(int index) async {
    isAppointmentLoading = true;
    update();
    try {
      var dateDay = DateTime.now().add(Duration(days: index));
      String day = dateDay.year.toString() +
          "-" +
          dateDay.month.toString() +
          "-" +
          dateDay.day.toString();
      var response = await _apiRequests.getMyBookings(day);
      myBookingsDaysList =
          (response.data as List).map((x) => DayResponse.fromJson(x)).toList();

      myBookingsDaysList.forEach((myBookingElement) {
        appointmentsList.forEach((element) {
          if (element.title.startsWith(myBookingElement.time!)) {
            element.isForMe = true;
            log(element.title);
          }
        });
      });
      update();
    } catch (e) {
      ErrorHandler.handleError(e, showToast: false);
    }
    isAppointmentLoading = false;
    update();
  }

  void getOtherBooking(int index) async {
    isAppointmentLoading = true;
    update();
    try {
      var dateDay = DateTime.now().add(Duration(days: index));
      String day = dateDay.year.toString() +
          "-" +
          dateDay.month.toString() +
          "-" +
          dateDay.day.toString();
      //log(day);
      var response = await _apiRequests.getOtherBookings(day);
      myBookingsDaysList =
          (response.data as List).map((x) => DayResponse.fromJson(x)).toList();

      myBookingsDaysList.forEach((myBookingElement) {
        appointmentsList.forEach((element) {
          if (element.title.startsWith(myBookingElement.time!)) {
            element.isAvailable = false;
            log(element.title);
          }
        });
      });
      update();

      log("myBookings => " + response.data.toString());
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isAppointmentLoading = false;
    update();
  }

  void sendMedicalForm(bool isVideo) async {
    if (birthDay == null) {
      Fluttertoast.showToast(msg: "Date_required".tr());
      return;
    }
    if (selectedSixValue == 0) {
      Fluttertoast.showToast(msg: "Please_gender".tr());
      return;
    }
    if (selectedSocialStatusValue == 0) {
      Fluttertoast.showToast(msg: "Please_status".tr());
      return;
    }
    if (selectedSmokeValue == 0) {
      Fluttertoast.showToast(msg: "Please_smoker".tr());
      return;
    }

    if (selectedAppointment == null) {
      Fluttertoast.showToast(msg: "Please_dates".tr());
      return;
    }
    isSendFormLoading = true;
    update();
    try {
      if (firstTime) {
        await _apiRequests.sendMedicalForm(
            fullName: nameController.text,
            gender: selectedSixValue == 1,
            telephone: phoneController.text,
            yearOfBirth:
                "${birthDay!.year}-${birthDay!.month}-${birthDay!.day}",
            isSmoker: selectedSmokeValue == 3,
            chronicDisease: buildChronicDiseaseString(),
            isPregnant: selectedValue == 3,
            address: addressController.text,
            history: buildHistoryString(),
            deviceType: kIsWeb
                ? 'web'
                : Platform.isIOS
                    ? 'iOS'
                    : Platform.isAndroid
                        ? 'Android'
                        : '');
      } else {
        await _apiRequests.editMedicalForm(
          fullName: nameController.text,
          gender: selectedSixValue == 1,
          telephone: phoneController.text,
          yearOfBirth: "${birthDay!.year}-${birthDay!.month}-${birthDay!.day}",
          isSmoker: selectedSmokeValue == 3,
          chronicDisease: buildChronicDiseaseString(),
          isPregnant: selectedValue == 3,
          address: addressController.text,
          history: buildHistoryString(),
        );
      }

      sendAppointment(isVideo);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isSendFormLoading = false;
    update();
  }

  void sendAppointment(bool isVideo) async {
    isSendFormLoading = true;
    update();
    try {
      var response = await _apiRequests.sendAppointment(
          day: buildDay(),
          time: appointmentsList[selectedAppointment!].title.substring(0, 5),
          isVideo: isVideo);

      Get.dialog(const SuccessDialog());
      log(response.data.toString());
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isSendFormLoading = false;
    update();
  }

  void cancelAppointment(index) async {
    Get.back();
    isLoading = true;
    update();
    try {
      var res = await _apiRequests.cancelAppointment(
        day: buildDay(),
        time: appointmentsList[index].title.substring(0, 5),
      );
      log("message");
      getNotAvailable(selectedDay);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }

  String buildChronicDiseaseString() {
    String all = '';
    if (bloodPressure) all + " ضغط دم";
    if (drunken) all + " سكري";
    if (sensitive) all + " حساسية";
    if (heartDisease) all + " امراض قلب ";
    if (diseaseController.text != '') all + diseaseController.text;

    return all;
  }

  String buildHistoryString() {
    if (selectedSocialStatusValue == 1) {
      return 'Married'.tr();
    } else if (selectedSocialStatusValue == 2) {
      return 'اعزب';
    } else if (selectedSocialStatusValue == 3) {
      return 'مطلق';
    } else if (selectedSocialStatusValue == 4) {
      return 'ارمل';
    } else {
      return '';
    }
  }

  String buildDay() {
    return "${daysList[selectedDay].title.year}-${daysList[selectedDay].title.month}-${daysList[selectedDay].title.day}";
  }

  String getDayName(DateTime weekDay) {
    String day = '';
    switch (weekDay.weekday) {
      case 1:
        {
          day = "Monday".tr();
          break;
        }
      case 2:
        {
          day = "Tuesday".tr();
          break;
        }
      case 3:
        {
          day = "Wenday".tr();
          break;
        }
      case 4:
        {
          day = "Thursday".tr();
          break;
        }
      case 5:
        {
          day = "Friday".tr();
          break;
        }
      case 6:
        {
          day = "Saturday".tr();
          break;
        }
      case 7:
        {
          day = "Sunday".tr();
          break;
        }
    }
    return day;
  }

  List<DayModel> daysList = [
    DayModel(DateTime.now(), "${DateTime.now().day}-${DateTime.now().month}"),
    DayModel(DateTime.now().add(const Duration(days: 1)),
        "${DateTime.now().add(const Duration(days: 1)).day}-${DateTime.now().add(const Duration(days: 1)).month}"),
    DayModel(DateTime.now().add(const Duration(days: 2)),
        "${DateTime.now().add(const Duration(days: 2)).day}-${DateTime.now().add(const Duration(days: 2)).month}"),
    DayModel(DateTime.now().add(const Duration(days: 3)),
        "${DateTime.now().add(const Duration(days: 3)).day}-${DateTime.now().add(const Duration(days: 3)).month}"),
    DayModel(DateTime.now().add(const Duration(days: 4)),
        "${DateTime.now().add(const Duration(days: 4)).day}-${DateTime.now().add(const Duration(days: 4)).month}"),
    DayModel(DateTime.now().add(const Duration(days: 5)),
        "${DateTime.now().add(const Duration(days: 5)).day}-${DateTime.now().add(const Duration(days: 5)).month}"),
    DayModel(DateTime.now().add(const Duration(days: 6)),
        "${DateTime.now().add(const Duration(days: 6)).day}-${DateTime.now().add(const Duration(days: 6)).month}"),
  ];

  List<AppointmentModel> appointmentsList = [
    AppointmentModel(true, false, '09:00 _ 09:30'),
    AppointmentModel(true, false, '09:30 _ 10:00'),
    AppointmentModel(true, false, '10:00 _ 10:30'),
    AppointmentModel(true, false, '10:30 _ 11:00'),
    AppointmentModel(true, false, '11:00 _ 11:30'),
    AppointmentModel(true, false, '11:30 _ 12:00'),
    AppointmentModel(true, false, '12:00 _ 12:30'),
    AppointmentModel(true, false, '12:30 _ 01:00'),
    AppointmentModel(true, false, '01:00 _ 01:30'),
    AppointmentModel(true, false, '01:30 _ 02:00'),
    AppointmentModel(true, false, '02:00 _ 02:30'),
    AppointmentModel(true, false, '02:30 _ 03:00'),
    AppointmentModel(true, false, '03:00 _ 03:30'),
    AppointmentModel(true, false, '03:30 _ 04:00'),
    AppointmentModel(true, false, '04:00 _ 04:30'),
    AppointmentModel(true, false, '04:30 _ 05:00'),
    AppointmentModel(true, false, '05:00 _ 05:30'),
    AppointmentModel(true, false, '05:30 _ 06:00'),
    AppointmentModel(true, false, '06:00 _ 06:30'),
    AppointmentModel(true, false, '06:30 _ 07:00'),
    AppointmentModel(true, false, '07:00 _ 07:30'),
    AppointmentModel(true, false, '07:30 _ 08:00'),
    AppointmentModel(true, false, '08:00 _ 08:30'),
    AppointmentModel(true, false, '08:30 _ 09:00'),
    AppointmentModel(true, false, '09:00 _ 09:30'),
    AppointmentModel(true, false, '09:30 _ 10:00'),
  ];
}
