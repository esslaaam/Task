

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

myDio({
  @required String? url,
  @required String? methodType,
  @required dynamic dioBody,
  @required Map<String, dynamic>? dioHeaders,
  @required String? appLanguage,
  required BuildContext? context
}) async {
  Response? response;
  bool isSocketException = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    try {
      if (methodType == 'get') {
        response = await Dio()
            .get(
          url!,
          queryParameters: dioBody,
          options: Options(
              headers: dioHeaders,
              validateStatus: (int? status) => status! >= 200 && status <= 500),
        )
            .catchError((onError) {
          isSocketException = true;
        });
      } else if (methodType == 'post') {
        response = await Dio()
            .post(url!,
            data: dioBody,
            options: Options(
                headers: dioHeaders,
                validateStatus: (int? status) =>
                status! >= 200 && status <= 500))
            .catchError((onError) {
          isSocketException = true;
        });
      }
      print('Response is >>> ${response!.statusCode}');

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return responseMap(
            status: response.data['status'],
            message: response.data['message'],
            data: response.data['data']);
      }
      else if (response.statusCode! >= 500) {
        return responseMap(
            status: false, message: serverErrorError(appLanguage!));
      }
      else if (isSocketException) {
        return responseMap(
            status: false, message: weakInternetError(appLanguage!));
      }
      else if (response.statusCode == 401 || response.statusCode == 302) {
        print("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* no token");
      }
      else if (response.statusCode! >= 400 && response.statusCode! <= 499) {
        return responseMap(
            status: false, message: response.data['message'], data: response.data['data']);
      }
      else {
        return responseMap(status: false, message: globalError(appLanguage!), data: null);
      }
    } catch (e) {
      print('global Dio Error Weak Internet$e');
      return responseMap(status: false, message: globalError(appLanguage!), data: null);

    }
  } else {
    print('no network ');
    return responseMap(
        status: false, message: noInternetsError(appLanguage!), data: null);
  }
}

String missingParameterError(String appLanguage) {
  return 'يوجد حقل ناقص ومطلوب برجاء مراجعه الداله مره اخري';
}

String globalError(String appLanguage) {
  return appLanguage == 'ar'
      ? '! حدث خطأ يرجي التأكد من الانترنت اولا او مراجعه اداره التطبيق'
      : 'An error occurred, please check the internet first or review the application administration !';
}

String noInternetsError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'برجاء الإتصال بالإنترنت !'
      : 'Please Connect to Internet !';
}

String weakInternetError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'إشارة الإنترنت ضعيفة !'
      : 'Internet signal weak !';
}

String serverErrorError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'يوجد مشكلة فى السيرفر برجاء مراجعة إدارة التطبيق'
      : 'There is a problem with the server, please check the application management';
}

Map<dynamic, dynamic> responseMap(
    {bool? status, String? message, dynamic data }) {
  return {"status": status, "message": message.toString(), "data": data };
}