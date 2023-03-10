

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
            success: response.data['success'],
            message: response.data['message'],
            data: response.data['data']);
      }
      else if (response.statusCode! >= 500) {
        return responseMap(
            success: false, message: serverErrorError(appLanguage!));
      }
      else if (isSocketException) {
        return responseMap(
            success: false, message: weakInternetError(appLanguage!));
      }
      else if (response.statusCode == 401 || response.statusCode == 302) {
        print("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* no token");
      }
      else if (response.statusCode! >= 400 && response.statusCode! <= 499) {
        return responseMap(
            success: false, message: response.data['message'], data: response.data['data']);
      }
      else {
        return responseMap(success: false, message: globalError(appLanguage!), data: null);
      }
    } catch (e) {
      print('global Dio Error Weak Internet$e');
      return responseMap(success: false, message: globalError(appLanguage!), data: null);

    }
  } else {
    print('no network ');
    return responseMap(
        success: false, message: noInternetsError(appLanguage!), data: null);
  }
}

String missingParameterError(String appLanguage) {
  return '???????? ?????? ???????? ???????????? ?????????? ???????????? ???????????? ?????? ????????';
}

String globalError(String appLanguage) {
  return appLanguage == 'ar'
      ? '! ?????? ?????? ???????? ???????????? ???? ???????????????? ???????? ???? ???????????? ?????????? ??????????????'
      : 'An error occurred, please check the internet first or review the application administration !';
}

String noInternetsError(String appLanguage) {
  return appLanguage == 'ar'
      ? '?????????? ?????????????? ?????????????????? !'
      : 'Please Connect to Internet !';
}

String weakInternetError(String appLanguage) {
  return appLanguage == 'ar'
      ? '?????????? ???????????????? ?????????? !'
      : 'Internet signal weak !';
}

String serverErrorError(String appLanguage) {
  return appLanguage == 'ar'
      ? '???????? ?????????? ???? ?????????????? ?????????? ???????????? ?????????? ??????????????'
      : 'There is a problem with the server, please check the application management';
}

Map<dynamic, dynamic> responseMap(
    {bool? success, String? message, dynamic data }) {
  return {"success": success, "message": message.toString(), "data": data };
}