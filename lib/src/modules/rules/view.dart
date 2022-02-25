import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_button_widget.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'logic.dart';

class RulesPage extends StatelessWidget {
  final RulesLogic logic = Get.put(RulesLogic());

  RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.getDoctorRules();
    return GetBuilder<RulesLogic>(builder: (logic) {
      return Scaffold(
        body: logic.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Terms_and_conditions".tr(),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: HtmlWidget(
                      logic.rules,
                    ))),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kIsWeb ? 30 : 0),
                      child: Row(
                        children: [
                          GetBuilder<RulesLogic>(builder: (logic) {
                            return Checkbox(
                                value: logic.checked,
                                onChanged: logic.changeChecked);
                          }),
                          CustomText("agree_on".tr()),
                          CustomText(
                            "Terms_and_Conditions".tr(),
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: GetBuilder<RulesLogic>(builder: (logic) {
                            log("nn");
                            return CustomButtonWidget(
                                title: "next".tr(),
                                enable: logic.checked,
                                onClick: () => logic.next());
                          }))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kIsWeb ? 50 : 10,
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
