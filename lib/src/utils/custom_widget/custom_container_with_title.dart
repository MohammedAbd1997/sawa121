import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';

import 'custom_text.dart';

class CustomContainerWithTitle extends StatelessWidget {
  final String title;
  final Widget child;

  const CustomContainerWithTitle(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(color: Colors.grey.shade400)
          ),
          width: double.infinity,
          child: child,
        ),
        Row(
          children: [
            const CustomSizedBox(width: 30,),
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomText(title , color: primaryColor,fontSize: 12,)),
          ],
        ),
      ],
    );
  }
}
