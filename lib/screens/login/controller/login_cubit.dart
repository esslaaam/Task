import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/toast.dart';
import 'package:flutter_task/core/local/app_cached.dart';
import 'package:flutter_task/core/local/global_config.dart';
import 'package:flutter_task/core/remote/my_dio.dart';
import 'package:flutter_task/screens/home/view/home_view.dart';
import 'package:flutter_task/screens/login/model/login_model.dart';
import 'package:flutter_task/shared/local/cache_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSecure = false;

  void changeVisibility() {
    isSecure = !isSecure;
    emit(ChangeIconState());
  }


  Map<dynamic, dynamic>? loginResponse;
  LoginModel? loginModel;

  Future<void> login(context) async {

    if (!formKey.currentState!.validate()) return;
    print('>>>>>>>>>>>>>> getting Login data >>>>>>>>>');
    emit(LoginLoadingState());
    try {
      final formData = ({
        'mobile': emailCtrl.text,
        'password': passCtrl.text,
      });

      print(formData);

      loginResponse = await myDio(
        dioHeaders: null,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.login,
        methodType: 'post',
        dioBody: formData,
        context: context, appLanguage: null,
      );

      if (loginResponse!['success'] == false) {
        print(loginResponse);

        showToast(text: loginResponse!['message'], state: ToastStates.error);
        emit(LoginFailureState());
      } else {
        showToast(text: loginResponse!['message'], state: ToastStates.success);
        loginModel = LoginModel.fromJson(loginResponse!);
        saveDataToShared(loginModel!.data!, loginModel!.data!.token!);
        navigateAndFinish(context: context, widget: HomeScreen());
        emit(LoginSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    print('>>>>>>>>>>>>>> finishing Login data >>>>>>>>>');
  }

  saveDataToShared(Data user, String userToken) async {
    print('Start Saving data');
    CacheHelper.saveData(AppCached.id, user.id);
    CacheHelper.saveData(AppCached.token, userToken);
    CacheHelper.saveData(AppCached.name, user.name);
    CacheHelper.saveData(AppCached.email, user.email);
    CacheHelper.saveData(AppCached.image, user.image);
    print('Finish Saving data');
  }

}