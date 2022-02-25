
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sawa/src/modules/doctor/logic.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import '../../constant.dart';


class DeleteAppointmentDialog extends StatelessWidget {
  final int index;

  final DoctorLogic logic = Get.find<DoctorLogic>();

  DeleteAppointmentDialog(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 30.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
        child: Container(
            height: 150.h,
            padding: EdgeInsets.all(15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  scale: 2.5,
                ),
                 CustomText(
                  "Are_you_sure_to_cancel_the_reservation".tr(),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                logic.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => logic.cancelAppointment(index),
                              child:  CustomText(
                                "Yes".tr(),
                                color: primaryColor,
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          InkWell(
                              onTap: () => Get.back(),
                              child:  CustomText(
                                "no".tr(),
                                color: primaryColor,
                              )),
                        ],
                      )
              ],
            )));
  }
}
