
import 'package:flutter/material.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';

Widget CustomBottom({
  required BuildContext? context,
  required String? label,
  required GestureTapCallback? onPressed,
}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        width: width(context!) * 0.77,
        height: height(context) * 0.07,
        decoration:const BoxDecoration(
              color: AppColor.blueColor,
                borderRadius:  BorderRadius.all(Radius.circular(7))),
        child: Center(
            child: CustomText(
                text: label!,
                color:AppColor.whiteColor,
                fontSize:AppFonts.t4)),
      ),
    );
