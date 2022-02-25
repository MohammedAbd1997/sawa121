import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';
import 'custom_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final bool loading;
  final bool enable;
  final Color? color;
  final Color textColor;
  final double padding;
  final double height;
  final double width;
  final double widthBorder;
  final double radius;
  final double textSize;
  final Widget? icon;
  final Widget? sideIcon;

  const CustomButtonWidget(
      {required this.title,
      required this.onClick,
      this.loading = false,
      this.enable = true,
      this.color = primaryColor,
      this.textColor = Colors.white,
      this.width = 160,
      this.widthBorder = 0.01,
      this.height = 46,
      this.textSize = 14,
      this.radius = 12,
      this.icon,
      this.sideIcon,
      this.padding = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.symmetric(vertical: 5),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: textColor, width: widthBorder),
              borderRadius: BorderRadius.circular(radius.sp),
            )),
        onPressed: (loading || !enable) ? null : onClick,
        child: loading != null && loading == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade100))
            : SizedBox(
                width: double.infinity,
                height: kIsWeb ? 50 : null,
                child: Row(
                  children: [
                    const SizedBox(width: 5,),
                    SizedBox(
                      width: 20.w,
                      child: icon,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: CustomText(
                                title,
                                textAlign: TextAlign.center,
                                fontSize: textSize,
                                color: textColor,
                              ),
                            ),
                          ),
                          SizedBox(child: sideIcon)
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
