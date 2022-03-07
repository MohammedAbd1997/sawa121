import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import '../../../main.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginLogic logic = Get.put(LoginLogic());

/*

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 50.h,
            ),
            InkWell(
              onTap: () {
                if (context.locale == Locale('en')) {
                  context.setLocale(Locale('ar'));
                  RestartWidget.restartApp(context);
                } else {
                  context.setLocale(Locale('en'));
                  RestartWidget.restartApp(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  context.locale == Locale('en') ? 'EN' : 'AR',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Spacer(),
            Center(child: Image.asset("assets/images/logo.png")),
            const CustomSizedBox(
              height: 100,
            ),
            GetBuilder<LoginLogic>(builder: (logic) {
              return logic.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          color: Colors.grey.shade200,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.sp),
                            onTap: () => logic.loginByFacebook(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Row(
                                children: [
                                  CustomText(
                                    "sign_in_with_facebook".tr(),
                                    color: Colors.grey.shade600,
                                  ),
                                  const Spacer(),
                                  Image.asset("assets/images/icon_facebook.png")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          color: Colors.grey.shade200,
                          child: InkWell(
                            onTap: () => logic.googleSignIn(),
                            borderRadius: BorderRadius.circular(8.sp),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Row(
                                children: [
                                  CustomText(
                                    "sign_in_with_Google".tr(),
                                    color: Colors.grey.shade600,
                                  ),
                                  const Spacer(),
                                  Image.asset("assets/images/icon_google.png")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            const Spacer(),
            Center(child: Image.asset("assets/images/image_developers.png")),
            const CustomSizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
