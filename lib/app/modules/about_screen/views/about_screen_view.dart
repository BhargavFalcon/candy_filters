import 'dart:io';

import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/adService/banner_ads.dart';
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
              top: MySize.getHeight(280),
              child: Image.asset(
                AppImage.appIcon,
                height: MySize.getHeight(160),
              ),
            ),
            Positioned(
              top: MySize.getHeight(460),
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
                  imageWidget(
                    image: AppImage.facebook,
                    onTap: () {
                      urlLauncher(
                          url:
                              Uri.parse("http://facebook.com/falconsolutions/"),
                          name: "Facebook");
                    },
                  ),
                  SizedBox(
                    width: MySize.getWidth(20),
                  ),
                  imageWidget(
                    image: AppImage.twitter,
                    onTap: () {
                      urlLauncher(
                          url: Uri.parse("https://twitter.com/FalconSolCo"),
                          name: "Twitter");
                    },
                  ),
                  SizedBox(
                    width: MySize.getWidth(20),
                  ),
                  imageWidget(
                    image: AppImage.linkedin,
                    onTap: () {
                      urlLauncher(
                          url: Uri.parse(
                              "https://www.linkedin.com/company/falcon-solutions-m-s"),
                          name: "Linkedin");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: BannerAdsWidget(),
        ),
      );
    });
  }

  Widget imageWidget({required String image, required VoidCallback onTap}) {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          InkWell(
            onTap: onTap,
            child: Image.asset(
              image,
              height: MySize.getHeight(70),
              width: MySize.getHeight(70),
            ),
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
