
import 'package:flutter/material.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';

Widget CustomTextField({
  bool? isEnabled = false,
  String? hint,
  TextInputType? type,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool isSecure = false,
  TextEditingController? ctrl,
  EdgeInsetsGeometry? contentPadding,
  Function()? onTap,
  int maxLines= 1,
  Function? validation,
}) =>
    TextFormField(
      controller: ctrl,
      readOnly: isEnabled!,
      maxLines: maxLines,
      onTap: onTap,
      cursorColor: AppColor.blueColor,
      cursorHeight: 25,
      validator:validation != null
          ? (value) {
        return validation(value);
      }
          : (value) {},
      style: TextStyle(fontSize: AppFonts.t5, color: AppColor.blackColor),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        errorBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: AppColor.errorToast),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: AppColor.greyColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: AppColor.greyColor)

        ),
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:const BorderSide(color: AppColor.greyColor)

        ),
        hintText: hint,
        hintStyle:const TextStyle(
          color: AppColor.greyColor,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      keyboardType: type,
      obscureText: isSecure,
    );
