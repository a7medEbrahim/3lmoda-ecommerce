import 'package:almoda/core/app_images.dart';
import 'package:almoda/core/extensions.dart';
import 'package:almoda/core/routes/routes.dart';
import 'package:almoda/core/text_style.dart';
import 'package:almoda/screens/auth/auth_cubit.dart';
import 'package:almoda/widgets/Text_fileds/auth_text_field.dart';
import 'package:almoda/widgets/buttons/auth_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorS.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            context.goNamed(RoutesName.home);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 91.h),
                        SvgPicture.asset(
                          AppIcons.logoIcon,
                          width: 237.w,
                          height: 71.h,
                        ),
                        SizedBox(height: 46.9.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Form(
                                  key: cubit.signupFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AuthTextField(
                                        title: 'auth.full_name'.tr(),
                                        hintText: 'auth.enter_full_name'.tr(),
                                        controller: cubit.fullName,
                                      ),
                                      SizedBox(height: 32.h),
                                      AuthTextField(
                                        title: 'auth.mobile_number'.tr(),
                                        hintText:
                                            'auth.enter_mobile_number'.tr(),
                                        controller: cubit.mobileNumber,
                                        keyboardType: TextInputType.phone,
                                      ),
                                      SizedBox(height: 32.h),
                                      AuthTextField(
                                        title: 'auth.email_address'.tr(),
                                        hintText:
                                            'auth.enter_email_address'.tr(),
                                        controller: cubit.signupEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(height: 32.h),
                                      AuthTextField(
                                        obscureText: cubit.signupObscureText,
                                        suffixIcon: cubit.signupObscureText
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_rounded),
                                                onPressed: () {
                                                  cubit.showSignupPassword();
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_off),
                                                onPressed: () {
                                                  cubit.hideSignupPassword();
                                                },
                                              ),
                                        title: 'auth.password'.tr(),
                                        hintText: 'auth.enter_password'.tr(),
                                        controller: cubit.signupPassword,
                                        onFieldSubmitted: (p0) {
                                          if (cubit.signupFormKey.currentState!
                                              .validate()) {
                                            cubit.signupUser();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 56.h,
                                        child: state is SignupErrorState
                                            ? Text(
                                                cubit.signupErrorMsg,
                                                style: Poppins.w300.getStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.red),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      AuthButton(
                                        name: 'auth.sign_up',
                                        onTap: () {
                                          if (cubit.signupFormKey.currentState!
                                              .validate()) {
                                            cubit.signupUser();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
