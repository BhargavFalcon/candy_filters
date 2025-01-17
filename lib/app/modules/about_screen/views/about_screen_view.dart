import 'dart:io';

import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/about_screen_controller.dart';

class AboutScreenView extends GetView<AboutScreenController> {
  const AboutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppImage.aboutBg,
              height: MySize.screenHeight,
              width: MySize.screenWidth,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: MySize.getHeight(60),
              left: MySize.getWidth(5),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImage.back,
                  height: MySize.getWidth(50),
                ),
              ),
            ),
            Positioned(
              top: MySize.getHeight(120),
              child: Image.asset(
                AppImage.logo_text,
                height: MySize.getWidth(100),
              ),
            ),
            Positioned(
              top: MySize.getHeight(320),
              child: Image.asset(
                AppImage.appIcon,
                height: MySize.getHeight(160),
              ),
            ),
            Positioned(
              top: MySize.getHeight(500),
              child: Column(
                children: [
                  Text(
                    (Platform.isIOS)
                        ? "Version ${controller.appVersionName.value}"
                        : "Version ${controller.appVersionName.value}(${controller.appVersionCode.value})",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: MySize.getWidth(16),
                    ),
                  ),
                  SizedBox(
                    height: MySize.getHeight(10),
                  ),
                  Text(
                    "© ${DateTime.now().year} Falcon Solutions \n All Rights Reserved",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: MySize.getWidth(16),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      launchUrl(
                          Uri.parse("http://facebook.com/falconsolutions/"));
                    },
                    child: imageWidget(image: AppImage.facebook),
                  ),
                  SizedBox(
                    width: MySize.getWidth(20),
                  ),
                  InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("https://twitter.com/FalconSolCo"));
                      },
                      child: imageWidget(image: AppImage.twitter)),
                  SizedBox(
                    width: MySize.getWidth(20),
                  ),
                  InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            "https://www.linkedin.com/company/falcon-solutions-m-s"));
                      },
                      child: imageWidget(image: AppImage.linkedin))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget imageWidget({required String image}) {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            image,
            height: MySize.getHeight(70),
            width: MySize.getHeight(70),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              AppImage.line,
              height: MySize.getHeight(80),
            ),
          ),
        ],
      ),
    );
  }
}
