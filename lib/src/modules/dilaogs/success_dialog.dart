import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: Container(
        height: 200.h,
        padding: EdgeInsets.all(15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.check_circle_outlined,
              size: 40.sp,
              color: greenColor,
            ),
             CustomText(
              "Your_reservation_WhatsApp".tr(),
              textAlign: TextAlign.center,
            ),
            CustomButtonWidget(
                title: "done".tr(),
                onClick: () {
                  Get.back();
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
