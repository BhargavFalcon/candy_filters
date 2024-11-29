import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(const Duration(seconds: 2), () {
          showCircularDialog(Get.context!);
        }).then(
          (value) {
            Future.delayed(const Duration(seconds: 5), () {
              Get.offAllNamed(Routes.HOME);
            });
          },
        );
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
