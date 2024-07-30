import 'dart:convert';
import 'dart:developer';

import 'package:almoda/core/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;
  static final Map<String, dynamic> _headers = {};

  static init() {
    /*final dataUser = CacheHelper.getData("data_user");
    if (dataUser != null) {
      final token = CacheHelper.getUserData().token;
      _headers["Authorization"] = "Bearer $token";
    }*/
    dio = Dio(BaseOptions(baseUrl: Strings.baseUrl, headers: _headers));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        log('err ${error.response?.statusCode}', error: error);
        handler.next(error);
      },
    ));
    dio.interceptors.add(LogInterceptor(
      request: false,
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      error: true,
    ));
    // dio.interceptors.add(InterceptorsWrapper(
    //   onError: (error, handler) {
    //     final String message;
    //     if (error.type == DioExceptionType.connectionError) {
    //       message = 'err.connection_err';
    //     } else {
    //       message = 'err.err_unknown';
    //     }
    //     handler.next(error.copyWith(message: message));
    //   },
    // ));
  }

  static void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
    //print(dio.options.headers);
  }

/*
Future<void> getServiceBanner(String banner_group)async{
    await DioHelper.getDataTwo(
        caller:'getServiceBanner',
        url: '?op=get_service_banner_list',
        onSuccess: (value) {
          _allBanners=BannerModel.listFromJson(value.data); //list.map((e) => BannerModel.fromJson(e)).toList();
          getBannerList(banner_group);
          emit(BannerDataReady());
        },
        onError: (onError) async{
        });
  }
 */
  static Future<void> getDataTwo({
    required String endPoint,
    Map<String, dynamic> query = const {},
    BuildContext? context,
    Function()? onStart,
    Function(Response value)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    if (onStart != null) onStart();
    try {
      //url = get_url(url);
      //query = get_header(query);
      // Utility.myPrintX(
      //     'caller:$caller getDataTwo my_base_url:${HandleSession.my_base_url} parmeter url${url} query${query.toString()}');
      final value = await dio.get(endPoint, queryParameters: query);
      Utility.myPrintX(
          'value.data                 Start SSSSSSSSSSSSSSSSSSSSSS');
      Utility.myPrintX('${value.data}');
      Utility.myPrintX(
          'value.data                 end XXXXXXXXXXXXXXXXXXXXXXXX');
      if (value.statusCode == 200) {
        if (onSuccess != null) onSuccess(value);
      } else {
        if (onError != null) onError(value);
      }
    } catch (ex) {
      if (onError != null) onError(ex);
      // Utility.myPrintX(
      //     'getDataTwo HandleSession.my_base_url:${HandleSession.my_base_url} parmeter url${url} query${query.toString()}');
    }
  }

  static Future<void> postDataTwo({
    required String endPoint,
    Map<String, dynamic> query = const {},
    required Map<String, dynamic> data,
    BuildContext? context,
    Function()? onStart,
    Function(Response value)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    if (onStart != null) onStart();
    try {
      //url = get_url(url);
      //query = get_header(query);
      //Utility.myPrintX('caller:$caller postDataTwo my_base_url:${HandleSession.my_base_url} parmeter url${url} query${query.toString()} data$data');
      final value = await dio.post(endPoint,
          queryParameters: query, data: jsonEncode(data));
      if (value.statusCode == 200) {
        if (onSuccess != null) onSuccess(value);
      } else {
        if (onError != null) onError(value);
      }
    } on DioException catch (ex) {
      if (onError != null) {
        onError(ex);
      }
    }
  }
}

class Utility {
  static myPrintX(object) async {
    if (!kReleaseMode) print(object);
  }
}
