import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';
import 'package:sawa/src/utils/custom_widget/custom_container_with_title.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';
import 'package:sawa/src/utils/custom_widget/custom_text_form_feild.dart';
import 'package:sawa/src/utils/validation/validation.dart';
import 'package:sawa/src/utils/widgets/drawer.dart';
import 'package:sawa/src/utils/widgets/item_appointment.dart';
import 'package:sawa/src/utils/widgets/item_day.dart';

import 'logic.dart';

class DoctorPage extends StatefulWidget {
  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final DoctorLogic logic = Get.put(DoctorLogic());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    logic.getMedicalForm();
    logic.getNotAvailable(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/icon_doctor.png",
              height: 30.h,
            ),
            const CustomSizedBox(
              width: 10,
            ),
            CustomText(
              "your_doctor".tr(),
              color: primaryColor,
            ),
          ],
        ),
        elevation: 1,
        foregroundColor: primaryColor,
      ),
       drawer: kIsWeb ? null :const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 0),
          child: Form(
            key: _formKey,
            child: GetBuilder<DoctorLogic>(builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => logic.changeFirstTimeValue(true),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: logic.firstTime
                                      ? primaryColor
                                      : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: CustomText(
                                  "first_visit".tr(),
                                  color: logic.firstTime
                                      ? Colors.white
                                      : primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => logic.changeFirstTimeValue(false),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: !logic.firstTime
                                      ? primaryColor
                                      : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: CustomText(
                                  "Review".tr(),
                                  color: !logic.firstTime
                                      ? Colors.white
                                      : primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSizedBox(
                        height: 20,
                      ),
                      CustomText(
                        "Please_fill_out_the_form".tr(),
                        color: Colors.black54,
                      ),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      GetBuilder<DoctorLogic>(builder: (logic) {
                        return CustomContainerWithTitle(
                            "Personal_data".tr(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomSizedBox(
                                  height: 5,
                                ),
                                CustomTextFormFiled(
                                  hint: "full_name".tr(),
                                  controller: logic.nameController,
                                  validator: Validation.nameValidate,
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () => showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 30000)),
                                                lastDate: DateTime.now())
                                            .then((value) {
                                          logic.birthDay = value;
                                          logic.update();
                                        }),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: CustomText(
                                        logic.birthDay != null
                                            ? logic.formatBirthDay()
                                            : "Date_of_Birth".tr(),
                                        color: logic.birthDay != null
                                            ? Colors.black
                                            : Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    )),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomTextFormFiled(
                                  hint: "WhatsApp_number".tr(),
                                  controller: logic.phoneController,
                                  validator: Validation.whatsappValidate,
                                  keyboardType: TextInputType.phone,
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomTextFormFiled(
                                  hint: "Work".tr(),
                                  validator: Validation.filedValidate,
                                  controller: logic.addressController,
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomText("gender".tr()),
                                Row(
                                  children: [
                                    const CustomSizedBox(
                                      width: 10,
                                    ),
                                    CustomText("male".tr()),
                                    Radio(
                                        value: 1,
                                        groupValue: logic.selectedSixValue,
                                        onChanged: (val) =>
                                            logic.changeSixSelection(val)),
                                    CustomText("female".tr()),
                                    Radio(
                                        value: 2,
                                        groupValue: logic.selectedSixValue,
                                        onChanged: (val) =>
                                            logic.changeSixSelection(val)),
                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomText("pregnant".tr()),
                                Row(
                                  children: [
                                    const CustomSizedBox(
                                      width: 10,
                                    ),
                                    CustomText("Yes".tr()),
                                    Radio(
                                        value: 3,
                                        groupValue: logic.selectedValue,
                                        onChanged: (val) =>
                                            logic.changeSelection(val)),
                                    CustomText("no".tr()),
                                    Radio(
                                        value: 4,
                                        groupValue: logic.selectedValue,
                                        onChanged: (val) =>
                                            logic.changeSelection(val)),
                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomText("Social_status".tr()),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          CustomText("Married".tr()),
                                          Radio(
                                              value: 1,
                                              groupValue: logic
                                                  .selectedSocialStatusValue,
                                              onChanged: (val) => logic
                                                  .changeSocialStatusSelection(
                                                      val)),
                                          CustomText("single".tr()),
                                          Radio(
                                              value: 2,
                                              groupValue: logic
                                                  .selectedSocialStatusValue,
                                              onChanged: (val) => logic
                                                  .changeSocialStatusSelection(
                                                      val)),
                                          CustomText("Divorced".tr()),
                                          Radio(
                                              value: 3,
                                              groupValue: logic
                                                  .selectedSocialStatusValue,
                                              onChanged: (val) => logic
                                                  .changeSocialStatusSelection(
                                                      val)),
                                          Row(
                                            children: [
                                              CustomText("Widower".tr()),
                                              Radio(
                                                  value: 4,
                                                  groupValue: logic
                                                      .selectedSocialStatusValue,
                                                  onChanged: (val) => logic
                                                      .changeSocialStatusSelection(
                                                          val)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                      }),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      GetBuilder<DoctorLogic>(builder: (logic) {
                        return CustomContainerWithTitle(
                            "medical_data".tr(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                 CustomText("chronic_diseases".tr()),
                                Row(
                                  children: [
                                    const CustomSizedBox(
                                      width: 10,
                                    ),
                                     CustomText("blood_pressure".tr()),
                                    Checkbox(
                                        value: logic.bloodPressure,
                                        onChanged: (val) =>
                                            logic.changeDisease(val, 0)),
                                     CustomText("diabetes".tr()),
                                    Checkbox(
                                        value: logic.drunken,
                                        onChanged: (val) =>
                                            logic.changeDisease(val, 1)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const CustomSizedBox(
                                      width: 10,
                                    ),
                                     CustomText("sensitive".tr()),
                                    Checkbox(
                                        value: logic.sensitive,
                                        onChanged: (val) =>
                                            logic.changeDisease(val, 2)),
                                     CustomText("heart_disease".tr()),
                                    Checkbox(
                                        value: logic.heartDisease,
                                        onChanged: (val) =>
                                            logic.changeDisease(val, 3)),
                                  ],
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                CustomTextFormFiled(
                                  hint: "other".tr(),
                                  controller: logic.diseaseController,
                                  fontSize: 14,
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                 CustomText("smoked".tr()),
                                Row(
                                  children: [
                                    const CustomSizedBox(
                                      width: 10,
                                    ),
                                     CustomText("Yes".tr()),
                                    Radio(
                                        value: 3,
                                        groupValue: logic.selectedSmokeValue,
                                        onChanged: (val) =>
                                            logic.changeSmokeSelection(val)),
                                    CustomText("no".tr()),
                                    Radio(
                                        value: 4,
                                        groupValue: logic.selectedSmokeValue,
                                        onChanged: (val) =>
                                            logic.changeSmokeSelection(val)),
                                  ],
                                ),
                                /*                         const CustomSizedBox(
                            height: 10,
                          ),
                          const CustomText("نوع الاستشارة"),
                          Row(
                            children: [
                              const CustomSizedBox(
                                width: 10,
                              ),
                              const CustomText("زيارة اولى"),
                              Radio(
                                  value: 1,
                                  groupValue: logic.selectedTypeValue,
                                  onChanged: (val) =>
                                      logic.changeTypeSelection(val)),
                              const CustomText("مراجعة الطبيب"),
                              Radio(
                                  value: 2,
                                  groupValue: logic.selectedTypeValue,
                                  onChanged: (val) =>
                                      logic.changeTypeSelection(val)),
                            ],
                          ),*/
                              ],
                            ));
                      }),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      GetBuilder<DoctorLogic>(builder: (logic) {
                        return CustomContainerWithTitle(
                            "Book_doctor".tr(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40.h,
                                  child: logic.isAppointmentLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Center(
                                          child: CustomText(
                                          "October_2020".tr(),
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 70.h,
                                  child: ListView.builder(
                                      itemCount: logic.daysList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          ItemDay(index)),
                                ),
                                const CustomSizedBox(
                                  height: 10,
                                ),
                                kIsWeb
                                    ? GridView.builder(
                                        itemCount:
                                            logic.appointmentsList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                crossAxisSpacing: 5,
                                                mainAxisExtent: 50),
                                        itemBuilder: (context, index) =>
                                            ItemAppointment(index))
                                    : GridView.builder(
                                        itemCount:
                                            logic.appointmentsList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 2.5),
                                        itemBuilder: (context, index) =>
                                            ItemAppointment(index)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      radius: 10,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText("booked_up".tr())
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 10,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText("select_day".tr())
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 10,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText("Available_times".tr())
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const CircleAvatar(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                      radius: 10,
                                      child: Icon(
                                        Icons.circle,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText("Make_your_appointment".tr())
                                  ],
                                ),
                              ],
                            ));
                      }),
                      const CustomSizedBox(
                        height: 20,
                      ),
                      GetBuilder<DoctorLogic>(builder: (logic) {
                        return Row(
                          children: [
                            Expanded(
                              child: CustomButtonWidget(
                                  loading: logic.isSendFormLoading,
                                  title: "Send_to_your_doctor".tr(),
                                  width: Get.width * 0.7,
                                  textSize: 12,
                                  icon: Image.asset(
                                    "assets/images/icon_doctor_small.png",
                                    scale: 3,
                                  ),
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      logic.sendMedicalForm(false);
                                    }
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomButtonWidget(
                                  loading: logic.isSendFormLoading,
                                  title: "Book_video_call".tr(),
                                  width: Get.width * 0.7,
                                  textSize: 12,
                                  icon: Image.asset(
                                    "assets/images/icon_video_call.png",
                                    scale: 3,
                                  ),
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      logic.sendMedicalForm(true);
                                    }
                                  }),
                            ),
                          ],
                        );
                      }),
                      const CustomSizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
