import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sawa/src/constant.dart';
import 'package:sawa/src/utils/custom_widget/custom_sized_box.dart';
import 'package:sawa/src/utils/custom_widget/custom_text.dart';

import 'logic.dart';

class OnBoardingPage extends StatelessWidget {
  final OnBoardingLogic logic = Get.put(OnBoardingLogic());

  OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GetBuilder<OnBoardingLogic>(builder: (logic) {
        return logic.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (page) {
                      logic.currentPage = page;
                      logic.update();
                    },
                    itemCount: logic.onBList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20.sp),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              logic.onBList[index].title,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                              fontSize: 16,
                            ),
                            const CustomSizedBox(
                              height: 40,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(100.sp),
                                child: CachedNetworkImage(
                                  imageUrl: "http://sawa121.org/" +
                                      logic.onBList[index].imgUrl!,
                                  width: 200.sp,
                                  height: 200.sp,
                                  errorWidget: (_1, _2, _3) =>
                                      Image.asset("assets/images/logo.png",
                                        width: 200.sp,
                                        height: 200.sp,),
                                )),
                            const CustomSizedBox(
                              height: 40,
                            ),
                            CustomText(
                              logic.onBList[index].description,
                              color: Colors.white,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                    controller: logic.pageController,
                    physics: const ClampingScrollPhysics(),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: logic.buildPageIndicator(),
                    ),
                  ),
                  Positioned(
                      right: 20.w,
                      left: 20.w,
                      bottom: 44.h,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => logic.goToMainPage(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                ],
              );
      }),
    );
  }
}
