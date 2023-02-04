import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/local/app_cached.dart';
import 'package:flutter_task/core/local/global_config.dart';
import 'package:flutter_task/core/remote/my_dio.dart';
import 'package:flutter_task/screens/product/model/product_model.dart';
import 'package:flutter_task/shared/local/cache_helper.dart';

import 'product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  int afterIndex = 0 ;
  int afterCurrentIndex = 0;
  void getIndex(int index){
    afterIndex = index ;
    afterCurrentIndex = index ;
    emit(IndexState());
  }
  int? newCurrentIndex ;
  void changeIndex(int index){
    newCurrentIndex = index ;
    emit(ChangeIndexState());
  }

  Map<dynamic, dynamic>? productDetailsResponse;
  ProductDetailsModel? productDetailsModel;

  Future<void> getProductDetails(context, int id) async {
    print('>>>>>>>>>>>>>> getting product details data >>>>>>>>>');
    emit(ProductDetailsLoadingState());
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer ${CacheHelper.getData(key: AppCached.token)}'
      };
      final formData = ({
        'product_id': '$id',
      });

      print(formData);

      productDetailsResponse = await myDio(
        dioHeaders:CacheHelper.getData(key: AppCached.token) != null? headers:null,
        url: AllAppApiConfig.baseUrl + AllAppApiConfig.product,
        methodType: 'post',
        dioBody: formData,
        context: context,
        appLanguage: null,
      );

      if (productDetailsResponse!['success'] == false) {
        print(productDetailsResponse);
        emit(ProductDetailsErrorState());
      } else {
        print(productDetailsResponse);
        productDetailsModel =
            ProductDetailsModel.fromJson(productDetailsResponse!);
        emit(ProductDetailsSuccessState());
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    print('>>>>>>>>>>>>>> finishing product details data >>>>>>>>>');
  }

}