import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sawa/src/modules/main/logic.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import '../../../main.dart';
import '../../constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(
        init: Get.find<MainLogic>(),
        builder: (logic) {
          return Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: EdgeInsets.only(bottom: 15.h),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                  ),
                  child: logic.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : logic.user == null
                          ? Container()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(80.sp),
                                  child: CachedNetworkImage(
                                    imageUrl: logic.user?.imgUrl ?? '',
                                    width: 60.sp,
                                    height: 60.sp,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.white,
                                      size: 40.sp,
                                    ),
                                  ),
                                ),
                                CustomText(
                                  logic.user?.fullName,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                CustomTextNew(
                                  logic.user?.email,
                                  color: Colors.white,
                                  fontSize: 14,
                                )
                              ],
                            ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: CustomText(
                    "Main".tr(),
                    color: Colors.grey.shade700,
                  ),
                  onTap: () => logic.goToMain(),
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title:
                      CustomText("about_us".tr(), color: Colors.grey.shade700),
                  onTap: () => logic.goToAbout(),
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title:
                      CustomText("share_app".tr(), color: Colors.grey.shade700),
                  onTap: () {
                    logic.goToUrl();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: CustomText("map".tr(), color: Colors.grey.shade700),
                  onTap: () => logic.goToMap(),
                ),
                ListTile(
                  leading: const Icon(Icons.text_snippet_outlined),
                  title: CustomText("General_Instructions".tr(),
                      color: Colors.grey.shade700),
                  onTap: () => logic.goToInstructions(),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title:
                      CustomText("Log_out".tr(), color: Colors.grey.shade700),
                  onTap: () => logic.goToLogoutDialog(),
                ),
              ],
            ),
          );
        });
  }
}
