import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImage.homeBg,
            height: MySize.screenHeight,
            width: MySize.screenWidth,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: MySize.getHeight(250),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageWidget(AppImage.camera),
                    imageWidget(AppImage.gallery),
                    imageWidget(AppImage.share),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageWidget(AppImage.about),
                    imageWidget(AppImage.moreApps),
                    imageWidget(AppImage.rateUs),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageWidget(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        imagePath,
        height: MySize.getHeight(100),
        width: MySize.getHeight(100),
      ),
    );
  }
}
