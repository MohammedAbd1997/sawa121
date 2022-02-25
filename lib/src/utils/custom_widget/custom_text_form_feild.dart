import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomTextFormFiled extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final double? width;
  final double? height;
  final TextInputAction textInputAction;
  final double radius;
  final double fontSize;
  final int maxLines;
  final int? maxLength;
  final Widget? icon;
  final double paddingLR;
  final bool isPassword;
  final bool obscureText;
  final bool autofocus;
  final bool alignLabelWithHint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSave;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTapPassword;
  final Color fillColor;

  const CustomTextFormFiled(
      {Key? key,
      this.hint,
      this.controller,
      this.width,
      this.fillColor = Colors.white,
      this.icon,
      this.radius = 10,
      this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.onFieldSubmitted,
      this.errorText,
      this.isPassword = false,
      this.autofocus = false,
      this.obscureText = false,
      this.alignLabelWithHint = false,
      this.paddingLR = 0,
      this.fontSize = 15,
      this.height,
      this.maxLines = 1,
      this.maxLength,
      this.onSave,
      this.onTapPassword,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h,
      child: TextFormField(
        key: key,
        focusNode: FocusNode(),
        autofocus: autofocus,
        maxLines: maxLines,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: controller,
        obscureText: obscureText,
        onSaved: onSave,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        style: TextStyle(fontSize: fontSize.sp),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.sp)),
          contentPadding: EdgeInsets.symmetric(horizontal: kIsWeb ? 5.w :15.w),
            prefixIcon: icon,
            suffixIcon: isPassword
                ? InkWell(
                    onTap: onTapPassword,
                    child: obscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility))
                : null,
            errorText: errorText,
            labelText: kIsWeb ? null : hint,
            hintText : kIsWeb ? hint : null,
            errorStyle: TextStyle(fontSize: 16.sp ),
            labelStyle: TextStyle(fontSize: fontSize.sp ),
            alignLabelWithHint: alignLabelWithHint),
      ),
    );
  }
}
