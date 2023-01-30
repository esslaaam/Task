import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

}