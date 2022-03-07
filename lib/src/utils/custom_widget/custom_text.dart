import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color color;
  final TextAlign? textAlign;
  final Function()? onTap;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? height;

  const CustomText(this.text,
      {Key? key,
      this.fontSize,
      this.color = Colors.black,
      this.textAlign = TextAlign.start,
      this.onTap,
      this.fontWeight,
      this.maxLines,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fs = ((fontSize == null ? 12 : fontSize!) + 2);
    return Text(
      text == null ? "" : text!,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fs.sp,
          fontWeight: fontWeight,
          height: height),
      maxLines: maxLines,
    );
  }
}

class CustomTextNew extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color color;
  final TextAlign? textAlign;
  final Function()? onTap;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? height;

  const CustomTextNew(this.text,
      {Key? key,
      this.fontSize,
      this.color = Colors.black,
      this.textAlign = TextAlign.start,
      this.onTap,
      this.fontWeight,
      this.maxLines,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fs = ((fontSize == null ? 12 : fontSize!) + 2);
    return Text(
      text == null ? "" : text!,
      textAlign: textAlign,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: fs.sp,
          fontWeight: fontWeight,
          height: height),
      maxLines: maxLines,
    );
  }
}
