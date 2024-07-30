import 'dart:convert';

import 'package:almoda/core/service/cache_helper.dart';
import 'package:almoda/core/service/dio_helper.dart';
import 'package:almoda/core/service/endpoints.dart';
import 'package:almoda/models/error_responce.dart';
import 'package:almoda/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitAuthState()) {
    if (CacheHelper.getData('userResponse') != null) {
      final UserResponse userResponse = UserResponse.fromJson(
          jsonDecode(CacheHelper.getData('userResponse')));
      DioHelper.setToken(userResponse.token);
      user = userResponse.user;
    }
  }

  final dio = DioHelper.dio;
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final fullName = TextEditingController();
  final mobileNumber = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  late User user;
  String loginErrorMsg = '';
  String signupErrorMsg = '';
  bool loginObscureText = false;
  bool signupObscureText = false;

  Future<void> loginUser() async {
    emit(LoginLoadingState());
    try {
      final response = await dio.post(EndPoints.loginUser,
          data: {"email": loginEmail.text, "password": loginPassword.text});
      final userResponse = UserResponse.fromJson(response.data);
      DioHelper.setToken(userResponse.token);
      user = userResponse.user;
      CacheHelper.saveData(
        key: 'userResponse',
        value: jsonEncode(userResponse.toJson()),
      );
      emit(LoginSuccessState());
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
            final error404 = Error404.fromJson(e.response!.data);
            loginErrorMsg = error404.message;
          } else if (e.response!.statusCode == 400) {
            final error400 = Error400.fromJson(e.response!.data);
            loginErrorMsg = error400.errors.msg;
          } else {
            loginErrorMsg = 'Unknown error occurred';
          }
        } else {
          loginErrorMsg = 'No response from server';
        }
      } else {
        loginErrorMsg = 'An unexpected error occurred';
      }
      emit(LoginErrorState());
    }
  }

  Future<void> showLoginPassword() async {
    loginObscureText = false;
    emit(LoginShowPasswordState());
  }

  Future<void> hideLoginPassword() async {
    loginObscureText = true;
    emit(LoginHidePasswordState());
  }

  Future<void> signupUser() async {
    emit(SignupLoadingState());
    try {
      final response = await dio.post(EndPoints.signupUser, data: {
        "name": fullName.text,
        "email": signupEmail.text,
        "password": signupPassword.text,
        "rePassword": signupPassword.text,
        "phone": mobileNumber.text
      });
      final userResponse = UserResponse.fromJson(response.data);
      DioHelper.setToken(userResponse.token);
      user = userResponse.user;
      emit(SignupSuccessState());
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
            final error404 = Error404.fromJson(e.response!.data);
            signupErrorMsg = error404.message;
          } else if (e.response!.statusCode == 400) {
            final error400 = Error400.fromJson(e.response!.data);
            signupErrorMsg = error400.errors.msg;
          } else {
            signupErrorMsg = 'Unknown error occurred';
          }
        } else {
          signupErrorMsg = 'No response from server';
        }
      } else {
        signupErrorMsg = 'An unexpected error occurred';
      }
      emit(SignupErrorState());
    }
  }

  Future<void> showSignupPassword() async {
    signupObscureText = false;
    emit(SignupShowPasswordState());
  }

  Future<void> hideSignupPassword() async {
    signupObscureText = true;
    emit(SignupHidePasswordState());
  }

  @override
  Future<void> close() {
    loginPassword.dispose();
    loginEmail.dispose();
    mobileNumber.dispose();
    fullName.dispose();
    signupEmail.dispose();
    signupPassword.dispose();
    return super.close();
  }
}

abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {}

class SignupErrorState extends AuthState {}

class LoginShowPasswordState extends AuthState {}

class LoginHidePasswordState extends AuthState {}

class SignupShowPasswordState extends AuthState {}

class SignupHidePasswordState extends AuthState {}
