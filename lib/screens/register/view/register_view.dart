import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/custom_botton.dart';
import 'package:flutter_task/componants/custom_loading.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/custom_text_formfield.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:flutter_task/screens/home/view/home_view.dart';
import 'package:flutter_task/screens/login/view/login_view.dart';

import '../controller/register_cubit.dart';
import '../controller/register_states.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = RegisterCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.05,
                      vertical: height(context) * 0.02),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: height(context) * 0.15),
                        CustomText(
                            text: "Welcome to My App",
                            color: AppColor.blackColor,
                            fontSize: AppFonts.t3,
                            fontweight: FontWeight.bold),
                        SizedBox(height: height(context) * 0.015),
                        CustomText(
                            text: "Create a new account",
                            color: AppColor.greyColor,
                            fontSize: AppFonts.t5),
                        SizedBox(height: height(context) * 0.035),
                        CustomTextField(
                          hint: "Name",
                          type: TextInputType.name,
                          ctrl: cubit.nameCtrl,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height(context) * 0.015),
                        CustomTextField(
                          hint: "Phone number",
                          type: TextInputType.phone,
                          ctrl: cubit.phoneCtrl,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Phone can\'t be empty';
                            }
                            else if(!RegExp (r"^[0-9]*$").hasMatch(cubit.phoneCtrl.text)){
                              return 'Invalid Phone Number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height(context) * 0.015),
                        CustomTextField(
                          hint: "Email",
                          type: TextInputType.emailAddress,
                          ctrl: cubit.emailCtrl,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be empty';
                            } else if (!value.contains('@')) {
                              return 'Email must contain @';
                            } else if (!RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(cubit.emailCtrl.text)) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height(context) * 0.015),
                        CustomTextField(
                          hint: "Password",
                          type: TextInputType.visiblePassword,
                          ctrl: cubit.passCtrl,
                          isSecure: cubit.isSecure,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeVisibility();
                              },
                              icon: Icon(
                                  cubit.isSecure == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.greyColor,
                                  size: 25)),
                        ),
                        SizedBox(height: height(context) * 0.015),
                        CustomTextField(
                          hint: "Confirm Password",
                          type: TextInputType.visiblePassword,
                          ctrl: cubit.confirmPassCtrl,
                          isSecure: cubit.isSecuree,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }

                            else if (value != cubit.passCtrl.text){
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeeeVisibility();
                              },
                              icon: Icon(
                                  cubit.isSecuree == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.greyColor,
                                  size: 25)),
                        ),
                        SizedBox(height: height(context) * 0.035),
                        state is RegisterLoadingState ? CustomLoading():CustomBottom(
                            context: context, label: "Register", onPressed: () async{
                              await cubit.register(context) ;
                        }),
                        SizedBox(height: height(context) * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: "Already have an account ?",
                                color: AppColor.greyColor,
                                fontSize: AppFonts.t5),
                            SizedBox(width: width(context) * 0.015),
                            InkWell(
                              onTap: (){
                                navigateAndReplace(context: context, widget:  LoginScreen());
                              },
                              child: CustomText(
                                  text: "Login",
                                  color: AppColor.blueColor,
                                  fontSize: AppFonts.t5,
                                  fontweight: FontWeight.bold),
                            ),

                          ],
                        ),
                        SizedBox(height: height(context) * 0.02),
                        InkWell(
                            onTap: () {
                              navigateTo(context, HomeScreen());
                            },
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: width(context)*0.01,vertical: height(context)*0.01),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: "Skip",
                                      color: AppColor.blueColor,
                                      fontSize: AppFonts.t5,
                                      fontweight: FontWeight.bold),
                                  SizedBox(width: width(context) * 0.008),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: AppColor.blueColor,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
