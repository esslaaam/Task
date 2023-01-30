import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                body: Column(
                  children: [],
                ),
              ),
            );
          }),
    );
  }
}
