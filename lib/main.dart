import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/componants/style/colors.dart';
import 'bloc_observer.dart';
import 'screens/login/view/login_view.dart';
import 'shared/local/cache_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.whiteColor,
      ),
      home: LoginScreen(),
    );
  }
}
