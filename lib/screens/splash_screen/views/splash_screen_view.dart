import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tot_pro/utils/data/core/values/app_assets.dart';
export 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreendView extends GetView<SplashScreenController> {
  const SplashScreendView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
          Image.asset(AppAssets.appLogo,
              fit: BoxFit.cover, height: 200, width: 200),
          const SizedBox(height: 20),
          const Text(
              'Copyright © 2024 \n  TOT PRO Design & Developed: Mento Software',
              style: TextStyle(fontWeight: FontWeight.bold))
        ]))));
  }
}
