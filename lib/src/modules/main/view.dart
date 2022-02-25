import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';
import 'package:sawa/src/utils/widgets/drawer.dart';

import 'logic.dart';

class MainPage extends StatelessWidget {
  final MainLogic logic = Get.find();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? buildWebScaffold()
        : Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              foregroundColor: primaryColor,
              backgroundColor: Colors.white,
              title: CustomText(
                "Main".tr(),
                color: primaryColor,
                fontSize: 16,
              ),
              centerTitle: false,
              elevation: 1,
            ),
            drawer: const MyDrawer(),
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const CustomSizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: 110.w,
                      ),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 5,
                        shadowColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp)),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 15.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => logic.goToCall('121'),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.call,
                                        color: Colors.blue,
                                      ),
                                      CustomSizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        "121",
                                        color: Colors.black54,
                                        fontSize: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 50.h,
                                width: 1,
                                color: Colors.grey,
                              ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => logic.goToCall('1800500121'),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        "Jerusalem".tr(),
                                      ),
                                      CustomSizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        "1800500121",
                                        color: Colors.black54,
                                        fontSize: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 50.h,
                                width: 1,
                                color: Colors.grey,
                              ),
                              const CustomSizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => logic.goToCall('+972594040121'),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "assets/images/icon_whatsapp.png"),
                                      const CustomSizedBox(
                                        height: 10,
                                      ),
                                      const CustomText(
                                        "+972594040121",
                                        color: Colors.black54,
                                        fontSize: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.sp),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.all(20.sp),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: primaryColor.withOpacity(0.15),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: Offset(3, 3))
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.sp),
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   CustomText(
                                    "type_of_harassment".tr(),
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  GetBuilder<MainLogic>(builder: (logic) {
                                    return DropdownButton(
                                      iconSize: 0,
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                      isExpanded: true,
                                      onChanged: (newValue) {
                                        logic.setSelected(newValue);
                                      },
                                      value: logic.selected,
                                      items: logic.categoriesList
                                          .map((selectedType) {
                                        return DropdownMenuItem(
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                CustomText(
                                                  selectedType.name.toString(),
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14,
                                                ),
                                                const Spacer(),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey.shade700,
                                                )
                                              ],
                                            ),
                                          ),
                                          value: selectedType,
                                        );
                                      }).toList(),
                                    );
                                  }),
                                  Center(
                                      child: CustomButtonWidget(
                                        width: 200.w,
                                          title: "Select_your_location".tr(),
                                          radius: 6,
                                          sideIcon:
                                              const Icon(Icons.location_on),
                                          onClick: () =>
                                              logic.goToMap(logic.selected)))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    color: Colors.white,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: CustomText(
                                      "Send_your_report".tr(),
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      /* CustomButtonWidget(title: "أرسل بلاغك", onClick: () =>logic.goToSendReport()),*/
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.sp),
                        child: CustomButtonWidget(
                            title: "Call_Me_back".tr(),
                            width: Get.width * 0.7,
                            onClick: () => logic.goToUrl()),
                      ),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const CustomSizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.sp),
                                onTap: () => logic.goToDoctor(),
                                child: Padding(
                                  padding: EdgeInsets.all(15.sp),
                                  child: Row(
                                    children: [
                                      const CustomSizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        "assets/images/icon_doctor.png",
                                        height: 50.sp,
                                      ),
                                      const CustomSizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomSizedBox(
                                            height: 10,
                                          ),
                                          CustomText(
                                            "your_doctor".tr(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomText(
                                            "Medical_Consultation".tr(),
                                            color: Colors.grey,
                                          ),
                                          const CustomSizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          /*
                  const CustomSizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.sp),
                        onTap: (){},
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Column(
                            children: [
                              const CustomSizedBox(
                                height: 10,
                              ),
                              Image.asset("assets/images/icon_booking.png", height: 50.sp,),
                              const CustomText("حجز موعد"),
                              const CustomText(
                                "مكالمة فيديو",
                                color: Colors.grey,
                              ),
                              const CustomSizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),*/
                          const CustomSizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const CustomSizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 40.h),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.sp),
                              topRight: Radius.circular(30.sp),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: primaryColor,
                                blurRadius: 5,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () => logic.goToCall('100'),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 40.h),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children:  [
                                            CustomSizedBox(
                                              height: 15,
                                            ),
                                            CustomText(
                                              "police".tr(),
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            CustomSizedBox(
                                              height: 10,
                                            ),
                                            CustomText("100",
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                          "assets/images/icon_police.png"))
                                ],
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () => logic.goToCall('101'),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 40.h),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children:  [
                                            CustomSizedBox(
                                              height: 15,
                                            ),
                                            CustomText(
                                              "ambulance".tr(),
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            CustomSizedBox(
                                              height: 10,
                                            ),
                                            CustomText("101",
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                          "assets/images/icon_ambulance.png"))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Scaffold buildWebScaffold() {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 110.w,
              ),
              CustomText(
                "System_Referral".tr(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.125),
                child: CustomButtonWidget(
                    title: "Call_Me_back".tr(),
                    width: Get.width * 0.7,
                    onClick: () => logic.goToUrl()),
              ),
              Row(
                children: [
                  const CustomSizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.sp),
                        onTap: () => logic.goToDoctor(),
                        child: Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            children: [
                              const CustomSizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                "assets/images/icon_doctor.png",
                                height: 50.sp,
                              ),
                              const CustomSizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomSizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    "your_doctor".tr(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    "Medical_Consultation".tr(),
                                    color: Colors.grey,
                                  ),
                                  const CustomSizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CustomSizedBox(
                    width: 20,
                  ),
                ],
              ),
              const CustomSizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
