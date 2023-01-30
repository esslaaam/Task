import 'package:flutter/material.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:fluttertoast/fluttertoast.dart';

 showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: choseToastColor(state),
  textColor: Colors.white,
  fontSize: AppFonts.t5,
);

// enum
enum ToastStates {success , error, warning}

Color? choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = AppColor.blackColor;
      break;
    case ToastStates.error:
      color =  AppColor.errorToast;
      break;
    case ToastStates.warning:
      color =   AppColor.warningToast;
      break;
  }
  return color;
}