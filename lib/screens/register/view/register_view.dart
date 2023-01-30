import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                body: Column(
                  children: [],
                ),
              ),
            );
          }),
    );
  }
}
