import 'dart:io';

import 'package:candy_filters/constant/argumentConstant.dart';
import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:candy_filters/service/CameraService.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
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
                    imageWidget(
                      AppImage.camera,
                      onTap: () async {
                        await pickImage(ImageSource.camera).then((value) {
                          if (value != null) {
                            controller.profilePhoto.value = value.path;
                            print(controller.profilePhoto.value);
                            Get.offAllNamed(Routes.EDIT_SCREEN, arguments: {
                              ArgumentConstant.pickImage:
                                  controller.profilePhoto.value,
                            });
                          }
                        });
                      },
                    ),
                    imageWidget(AppImage.gallery, onTap: () async {
                      await pickImage(ImageSource.gallery).then((value) {
                        if (value != null) {
                          controller.profilePhoto.value = value.path;
                          print(controller.profilePhoto.value);
                          Get.offAllNamed(Routes.EDIT_SCREEN, arguments: {
                            ArgumentConstant.pickImage:
                                controller.profilePhoto.value,
                          });
                        }
                      });
                    }),
                    imageWidget(
                      AppImage.share,
                      onTap: () {
                        String text =
                            "More than 800+ emojis, filters and stickers. Download Candy Photo Filters & Stickers now:${Platform.isIOS ? "https://itunes.apple.com/us/app/id1189494806?ls=1&mt=8" : "https://play.google.com/store/apps/details?id=com.rohit.snappy&hl=en-IN"}";
                        Share.share(text);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageWidget(AppImage.about, onTap: () {
                      Get.toNamed(Routes.ABOUT_SCREEN);
                    }),
                    imageWidget(
                      AppImage.moreApps,
                      onTap: () {
                        launchUrl(Uri.parse(Platform.isIOS
                            ? ArgumentConstant.iosAccountLink
                            : ArgumentConstant.androidAccountLink));
                      },
                    ),
                    imageWidget(
                      AppImage.rateUs,
                      onTap: () {
                        controller.rateMyApp.launchStore();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageWidget(String imagePath, {void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          height: MySize.getHeight(100),
          width: MySize.getHeight(100),
        ),
      ),
    );
  }
}
