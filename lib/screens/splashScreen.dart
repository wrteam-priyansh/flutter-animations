import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:getx_route/app/routes.dart';
import 'package:getx_route/cubits/settingsCubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static Widget getRouteInstance() => BlocProvider(
        create: (_) => SettingsCubit(),
        child: const SplashScreen(),
      );
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (kDebugMode) {
          print("Current Route is ${Get.currentRoute}");
          Get.offNamed(Routes.homeScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
