import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/product_cubit.dart';
import '../controller/product_states.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = ProductCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [],
                ),
              ),
            );
          }),
    );
  }
}
