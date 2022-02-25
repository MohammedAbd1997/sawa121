import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';
import 'package:sawa/src/utils/custom_widget/custom_text_form_feild.dart';
import 'package:sawa/src/utils/validation/validation.dart';

import 'logic.dart';

class SendReportPage extends StatelessWidget {
  final SendReportLogic logic = Get.put(SendReportLogic());

  SendReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var source = Get.parameters['data'];
    if(source == null || source == ''){
      source = 'unknown';
    }
    logic.source = source;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryColor,
        child: SingleChildScrollView(
          child: GetBuilder<SendReportLogic>(builder: (logic) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp)),
              elevation: 5,
              margin: EdgeInsets.symmetric(
                  horizontal: 50.h, vertical: 50.h),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Row(
                        children: [
                          CustomText(
                            "send_your_report".tr(),
                            color: primaryColor,
                            fontSize: 20,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: ()=>logic.changeLanguage(true),
                            child: Image.asset(
                              "assets/images/ar.png",
                              scale: 2,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: ()=>logic.changeLanguage(false),
                            child: Image.asset(
                              "assets/images/en.png",
                              scale: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "Please_fields".tr(),
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  "Personal_data".tr(),
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              "name".tr(),
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormFiled(
                              hint: "name".tr(),
                              keyboardType: TextInputType.name,
                              validator: Validation.nameValidate,
                              controller: logic.nameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              "phone_number".tr(),
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormFiled(
                              hint: "0599222222",
                              keyboardType: TextInputType.phone,
                              validator: Validation.phoneValidate,
                              controller: logic.phoneController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              "Select_method".tr(),
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child:
                                  GetBuilder<SendReportLogic>(builder: (logic) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          iconSize: 20,
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          isExpanded: true,
                                          hint: Container(
                                            padding: const EdgeInsets.all(12),
                                            child: CustomText(
                                              "Choose_from_here".tr(),
                                              color: Colors.grey.shade700,
                                              fontSize: 13,
                                            ),
                                          ),
                                          onChanged: (newValue) {
                                            logic.setContactSelected(newValue);
                                          },
                                          value: logic.selectedContact,
                                          items: logic.contactList
                                              .map((selectedType) {
                                            return DropdownMenuItem(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: CustomText(
                                                  selectedType.toString(),
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              value: selectedType,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    /*
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),*/
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<SendReportLogic>(builder: (logic) {
                              return Visibility(
                                visible: logic.selectedContact != null,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextFormFiled(
                                      hint: "Enter_contact_information".tr(),
                                      validator: Validation.filedValidate,
                                      controller: logic.contactController,
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  "Reporting_data".tr(),
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              "Time_you".tr(),
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () => showDatePicker(
                                            context: context,
                                            
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(const Duration(days: 60)))
                                        .then((dateValue) {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                  hour: DateTime.now().hour,
                                                  minute:
                                                      DateTime.now().minute))
                                          .then((timeValue) {
                                        logic.birthDay = dateValue;
                                        logic.timeOfDay = timeValue;
                                        logic.date =
                                            "${logic.formatBirthDay()} : ${logic.formatTime()}";
                                        logic.update();
                                      });
                                    }),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        logic.birthDay != null
                                            ? logic.date
                                            : "- - -",
                                        color: logic.birthDay != null
                                            ? Colors.black
                                            : Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.timer_sharp,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              "Report_Status".tr(),
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: logic.selectedValue,
                                    onChanged: (val) =>
                                        logic.changeSelection(val)),
                                CustomText("Urgent".tr()),
                                Radio(
                                    value: 2,
                                    groupValue: logic.selectedValue,
                                    onChanged: (val) =>
                                        logic.changeSelection(val)),
                                CustomText("not_urgent".tr()),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: CustomButtonWidget(
                              title: "send".tr(),
                              loading: logic.isLoading,
                              onClick: () {
                                if (_formKey.currentState!.validate()) {
                                  logic.sendReport();
                                }
                              },
                              width: 200,
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
