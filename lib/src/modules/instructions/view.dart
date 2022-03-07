import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import '../../constant.dart';
import 'logic.dart';

class InstructionsPage extends StatelessWidget {
  final InstructionsLogic logic = Get.put(InstructionsLogic());

  @override
  Widget build(BuildContext context) {
    logic.getInstructions();
    logic.getInstructionsEn();
    return GetBuilder<InstructionsLogic>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: CustomText(
            "General_Instructions".tr(),
            fontSize: 16,
          ),
          elevation: 3,
        ),
        body: logic.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "General_Instructions".tr(),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      HtmlWidget(
                        context.locale == Locale('en')
                            ? logic.instructionsEn
                            : logic.instructions,
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
