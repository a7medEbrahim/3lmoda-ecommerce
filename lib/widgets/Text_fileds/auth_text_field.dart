import 'package:almoda/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.title,
      required this.hintText,
      this.suffixIcon,
      this.controller,
      this.obscureText = false,
      this.required = true,
      this.keyboardType,
      this.onFieldSubmitted});

  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool required;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr(),
          style: Poppins.w500.getStyle(fontSize: 18.sp, color: Colors.white),
        ),
        SizedBox(height: 24.h),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 23.h),
              hintText: hintText.tr(),
              hintStyle: Poppins.w300.getStyle(
                  fontSize: 18.sp, color: Colors.black.withOpacity(.7)),
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14.r)),
              suffixIcon: suffixIcon),
          validator: (value) {
            if (required && (value == null || value.isEmpty)) {
              return '${'auth.please_enter'.tr()} ${title.tr()}';
            }
            return null;
          },
        ),
      ],
    );
  }
}
