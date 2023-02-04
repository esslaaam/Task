import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/local/app_cached.dart';
import 'package:flutter_task/core/local/global_config.dart';
import 'package:flutter_task/core/remote/my_dio.dart';
import 'package:flutter_task/screens/home/model/home_model.dart';
import 'package:flutter_task/shared/local/cache_helper.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  Map<dynamic, dynamic>? homeResponse;
  ProductsModel? productsModel;
  Future<void> getProducts(context) async {
    print('>>>>>>>>>>>>>> getting Products data >>>>>>>>>');
    emit(HomeLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.token)}'
      };
      final formData = ({
        'category_id': '1',
      });

      print(formData);

      homeResponse = await myDio(
        dioHeaders: headers,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.home,
        methodType: 'post',
        dioBody: formData,
        context: context, appLanguage: null,
      );

      if (homeResponse!['success'] == false) {
        print(homeResponse);
        emit(HomeErrorState());
      } else {
        productsModel = ProductsModel.fromJson(homeResponse!);
        emit(HomeSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    print('>>>>>>>>>>>>>> finishing Products data >>>>>>>>>');
  }


}