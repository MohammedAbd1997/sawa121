import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';
import 'package:easy_localization/src/public_ext.dart';

class SuccessSendReportDialog extends StatelessWidget {
  const SuccessSendReportDialog({Key? key}) : super(key: key);

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
            Image.asset("assets/images/logo.png" , scale: 2.5,),
             CustomText(
              "Thank_you_for".tr(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
