import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetWidget<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImage.splash,
          height: MySize.screenHeight,
          width: MySize.screenWidth,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
