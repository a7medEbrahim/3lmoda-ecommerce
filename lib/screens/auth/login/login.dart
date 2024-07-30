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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorS.primary,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
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
                        SvgPicture.asset(AppIcons.logoIcon),
                        SizedBox(height: 86.9.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'auth.welcome_back'.tr(),
                                  style: Poppins.w600.getStyle(
                                      fontSize: 24.sp, color: Colors.white),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'auth.please_sign_in'.tr(),
                                  style: Poppins.w300.getStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                                SizedBox(height: 40.h),
                                Form(
                                  key: cubit.loginFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AuthTextField(
                                        title: 'auth.user_name'.tr(),
                                        hintText: 'auth.enter_user_name'.tr(),
                                        controller: cubit.loginEmail,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(height: 32.h),
                                      AuthTextField(
                                        obscureText: cubit.loginObscureText,
                                        suffixIcon: cubit.loginObscureText
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_rounded),
                                                onPressed: () {
                                                  cubit.showLoginPassword();
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_off),
                                                onPressed: () {
                                                  cubit.hideLoginPassword();
                                                },
                                              ),
                                        title: 'auth.password'.tr(),
                                        hintText: 'auth.enter_password'.tr(),
                                        controller: cubit.loginPassword,
                                        onFieldSubmitted: (p0) {
                                          if (cubit.loginFormKey.currentState!
                                              .validate()) {
                                            cubit.loginUser();
                                          }
                                        },
                                      ),
                                      SizedBox(height: 16.h),
                                      TextButton(
                                        onPressed: () {},
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'auth.forgot_password'.tr(),
                                            style: Poppins.w400.getStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 56.h,
                                        child: state is LoginErrorState
                                            ? Text(
                                                cubit.loginErrorMsg,
                                                style: Poppins.w300.getStyle(
                                                    fontSize: 16,
                                                    color: Colors.red),
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      AuthButton(
                                        name: 'auth.login',
                                        onTap: () {
                                          if (cubit.loginFormKey.currentState!
                                              .validate()) {
                                            cubit.loginUser();
                                          }
                                        },
                                      ),
                                      SizedBox(height: 32.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'auth.dont_have_account'.tr(),
                                            style: Poppins.w500.getStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                context.goNamed(
                                                    RoutesName.registration);
                                              },
                                              child: Text(
                                                  'auth.create_account'.tr(),
                                                  style: Poppins.w500.getStyle(
                                                      fontSize: 15.sp,
                                                      color: Colors.white)))
                                        ],
                                      )
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
