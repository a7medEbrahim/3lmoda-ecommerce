import 'package:almoda/core/extensions.dart';
import 'package:almoda/core/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.name, this.onTap});

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23.h),
          child: Center(
            child: Text(name.tr(),
                style: Poppins.w600.getStyle(
                  fontSize: 20.sp,
                  color: context.colorS.primary,
                )),
          ),
        ),
      ),
    );
  }
}
