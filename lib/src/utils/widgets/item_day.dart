import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sawa/src/modules/doctor/logic.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

class ItemDay extends StatelessWidget {
  final int index;
  const ItemDay(this.index , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorLogic>(
        init: Get.find<DoctorLogic>(),
        builder: (logic) {
      return InkWell(
        borderRadius: BorderRadius.circular(35.sp),
        onTap: () =>
            logic.changeDaySelection(index),
        child: CircleAvatar(
          radius: 30.sp,
          backgroundColor: logic.selectedDay == index ? Colors.blue : Colors.white,
          child: Center(
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                CustomText(
                  logic.getDayName(logic
                      .daysList[index]
                      .title),
                  color:
                  logic.selectedDay ==
                      index
                      ? Colors.white
                      : Colors.black,
                ),
                CustomText(
                  logic
                      .daysList[index].date,
                  color:
                  logic.selectedDay ==
                      index
                      ? Colors.white
                      : Colors.black,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
