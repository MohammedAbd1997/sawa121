import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sawa/src/modules/doctor/logic.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import '../../constant.dart';

class ItemAppointment extends StatelessWidget {
  final int index;
  const ItemAppointment(this.index , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorLogic>(
        init: Get.find<DoctorLogic>(),
        builder: (logic) {
      return InkWell(
        onTap: () =>
            logic.selectAppointment(index),
        borderRadius:
        BorderRadius.circular(5.sp),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 8),
              height: double.infinity,
              decoration: BoxDecoration(
                  color: logic
                      .appointmentsList[
                  index]
                      .isForMe
                      ? Colors.white
                      : logic
                      .appointmentsList[
                  index]
                      .isAvailable
                      ? logic.selectedAppointment ==
                      index
                      ? Colors.white
                      : Colors.green
                      : Colors.red,
                  borderRadius:
                  BorderRadius.circular(
                      5.sp),
                  border: Border.all(
                      width: 2,
                      color: logic
                          .appointmentsList[
                      index]
                          .isAvailable
                          ? (logic.selectedAppointment ==
                          index ||
                          logic
                              .appointmentsList[
                          index]
                              .isForMe)
                          ? primaryColor
                          : Colors.green
                          : Colors.red)),
              child: Center(
                child: CustomText(
                  logic
                      .appointmentsList[index]
                      .title,
                  fontSize: 10,
                  color: (logic.selectedAppointment ==
                      index ||
                      logic
                          .appointmentsList[
                      index]
                          .isForMe)
                      ? primaryColor
                      : Colors.white,
                ),
              ),
            ),
            if (logic.appointmentsList[index]
                .isForMe)
              InkWell(
                onTap: () =>
                    logic
                        .openCancelDialog(index),
                child: const CircleAvatar(
                  radius: 8,
                  backgroundColor:
                  primaryColor,
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
