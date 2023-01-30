import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish({required context,required widget}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);



 navigatorPop(context)=> Navigator.pop(context);


navigateAndReplace({required context,required widget}) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),);