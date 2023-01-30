import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/home_cubit.dart';
import '../controller/home_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
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
