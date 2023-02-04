import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/custom_botton.dart';
import 'package:flutter_task/componants/custom_loading.dart';
import 'package:flutter_task/componants/custom_text.dart';
import 'package:flutter_task/componants/custom_text_formfield.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'package:flutter_task/componants/style/size.dart';
import 'package:flutter_task/screens/register/view/register_view.dart';
import '../controller/login_cubit.dart';
import '../controller/login_states.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = LoginCubit.get(context);
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
                        SizedBox(height: height(context) * 0.23),
                        CustomText(
                            text: "Welcome to My App",
                            color: AppColor.blackColor,
                            fontSize: AppFonts.t3,
                            fontweight: FontWeight.bold),
                        SizedBox(height: height(context) * 0.015),
                        CustomText(
                            text: "Sign in to continue",
                            color: AppColor.greyColor,
                            fontSize: AppFonts.t5),
                        SizedBox(height: height(context) * 0.035),
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
                        SizedBox(height: height(context) * 0.035),
                        state is LoginLoadingState ? CustomLoading(): CustomBottom(
                            context: context, label: "Login", onPressed: ()async {
                              await cubit.login(context);
                        }),
                        SizedBox(height: height(context) * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: "Don’t have an account ?",
                                color: AppColor.greyColor,
                                fontSize: AppFonts.t5),
                            SizedBox(width: width(context) * 0.015),
                            InkWell(
                              onTap: (){
                                navigateAndReplace(context: context, widget: RegisterScreen());
                              },
                              child: CustomText(
                                  text: "Register",
                                  color: AppColor.blueColor,
                                  fontSize: AppFonts.t5,
                              fontweight: FontWeight.bold),
                            ),

                          ],
                        ),
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
