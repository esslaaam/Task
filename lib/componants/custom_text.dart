import 'package:flutter/cupertino.dart';

Widget CustomText(
        {Key? key,
        String? text,
        Color? color,
        double? fontSize,
        double? wordSpacing,
        TextAlign? textAlign,
        FontWeight? fontweight,
        String? fontFamily,
        TextOverflow? overflow,
        int? maxLines,
        TextDecoration? decoration}) =>
    Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontweight,
          fontFamily: fontFamily,
          decoration: decoration,
        wordSpacing: wordSpacing,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
