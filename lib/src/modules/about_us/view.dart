import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import 'logic.dart';

class AboutUsPage extends StatelessWidget {
  final AboutUsLogic logic = Get.put(AboutUsLogic());

  AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          "about_us".tr(),
          fontSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 60.w,
                    ),
                    const CustomSizedBox(
                      width: 10,
                    ),
                    CustomText(
                      "Sawa_Corporation".tr(),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(
                height: 20,
              ),
              GetBuilder<AboutUsLogic>(builder: (logic) {
                return logic.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomText(
                        logic.aboutUsResponse?.aboutDtos?[0].content,
                        textAlign: TextAlign.center,
                      );
              }),
              const CustomSizedBox(
                height: 100,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/image_developers.png",
                      width: 60.w,
                    ),
                    const CustomSizedBox(
                      width: 10,
                    ),
                    CustomText(
                      "Developers_Plus_Company".tr(),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(
                height: 20,
              ),
              CustomText(
                "developer_about".tr(),
                textAlign: TextAlign.center,
              ),
              const CustomSizedBox(
                height: 20,
              ),
              CustomText(
                "contact_us".tr(),
                fontWeight: FontWeight.bold,
              ),
              const CustomSizedBox(
                height: 10,
              ),
              CustomText("${"email".tr()} :         info@developers.ps"),
              const CustomSizedBox(
                height: 10,
              ),
              CustomText("${"Mobile_number".tr()} :   972592805007+"),
              const CustomSizedBox(
                height: 10,
              ),
              CustomText("${"phone_number".tr()} :   2472411"),
            ],
          ),
        ),
      ),
    );
  }
}
