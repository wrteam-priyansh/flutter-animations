import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_route/screens/musicAnimationScreen.dart';
import 'package:getx_route/screens/tabAnimationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget getRouteInstance() => const HomeScreen();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500));

  late final Animation<double> _bottomToCenterTextAnimation =
      Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
          parent: _animationController, curve: const Interval(0.0, 0.25)));

  late final Animation<double> _centerToTopTextAnimation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: const Interval(0.75, 1.0)));

  late int _counter = 0;

  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   if (kDebugMode) {
    //     print(
    //         "Current route is ${Get.currentRoute} and previous route is ${Get.previousRoute}");
    //   }
    // });

    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      setState(() {
        _counter++;
      });
      _animationController.forward(from: 0.0);
    });

    //
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const TabAnimationScreen());
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.navigate_next),
          onPressed: () {
            Get.to(() => const MusicAnimationScreen());
            //Get.toNamed(Routes.assignmentsScreen);
          }),
      body: Center(
        child: AnimatedBuilder(
            animation: _bottomToCenterTextAnimation,
            builder: (context, child) {
              final dy = _bottomToCenterTextAnimation.value -
                  _centerToTopTextAnimation.value;

              final opacity = (1 -
                  _bottomToCenterTextAnimation.value -
                  _centerToTopTextAnimation.value);

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                alignment: Alignment(0, dy),
                child: Opacity(
                    opacity: opacity,
                    child: const Text("Anything will be come here")),
              );
            }),
      ),
    );
  }
}
