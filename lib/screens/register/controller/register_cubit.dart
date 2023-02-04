import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/my_navigate.dart';
import 'package:flutter_task/componants/toast.dart';
import 'package:flutter_task/core/local/app_cached.dart';
import 'package:flutter_task/core/local/global_config.dart';
import 'package:flutter_task/core/remote/my_dio.dart';
import 'package:flutter_task/screens/home/view/home_view.dart';
import 'package:flutter_task/screens/register/model/register_model.dart';
import 'package:flutter_task/shared/local/cache_helper.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSecure = false;
  bool isSecuree = false;

  void changeVisibility() {
    isSecure = !isSecure;
    emit(ChangeIconState());
  }

  void changeeeVisibility() {
    isSecuree = !isSecuree;
    emit(ChangeIcon2State());
  }


  Map<dynamic, dynamic>? registerResponse;
  RegisterModel? registerModel;

  Future<void> register(context) async {

    if(!formKey.currentState!.validate()) return;
    print('>>>>>>>>>>>>>> getting Register data >>>>>>>>>');
    emit(RegisterLoadingState());

    try {
      final formData = ({
        'name': nameCtrl.text,
        'mobile': phoneCtrl.text,
        'email': emailCtrl.text,
        'password': passCtrl.text,
        'password_confirmation': confirmPassCtrl.text,
      });

      print(formData);

      registerResponse = await myDio(
        appLanguage: null,
        dioHeaders: null,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.register,
        methodType: 'post',
        dioBody: formData,
        context: context,
      );

      if (registerResponse!['success'] == false) {
        showToast(text: registerResponse!['message'], state: ToastStates.error);
        emit(RegisterFailureState());
      } else {
        showToast(text: registerResponse!['message'], state: ToastStates.success);
        registerModel = RegisterModel.fromJson(registerResponse!);
        saveDataToShared(registerModel!.data!, registerModel!.data!.token.toString());
        navigateAndFinish(context: context, widget: HomeScreen());
        print(registerResponse);
        emit(RegisterSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }

    print('>>>>>>>>>>>>>> finishing Register data >>>>>>>>>');
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