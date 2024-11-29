import 'dart:io';

import 'package:candy_filters/app/routes/app_pages.dart';
import 'package:candy_filters/constant/color_constant.dart';
import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_screen_controller.dart';

class EditScreenView extends GetView<EditScreenController> {
  const EditScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fromHex('#080A52'),
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(Routes.HOME);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              AppImage.back,
            ),
          ),
        ),
        actions: [
          Image.asset(
            AppImage.eraser,
            height: MySize.getHeight(45),
          ),
        ],
        title: Text(
          'Candy Filters',
          style: TextStyle(
            color: Colors.white,
            fontSize: MySize.getHeight(18),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: fromHex('#F9A8B4'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Image.file(
              File(
                controller.profilePhoto.value,
              ),
              filterQuality: FilterQuality.high,
            ),
          ),
          Spacer(),
          Container(
            height: MySize.getHeight(200),
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    child: Container(
                  height: MySize.getHeight(150),
                  color: Colors.black,
                )),
                Container(
                  height: MySize.getHeight(120),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.bottom),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          AppImage.smile,
                          height: MySize.getHeight(45),
                        ),
                      ),
                      Image.asset(
                        AppImage.text,
                        height: MySize.getHeight(25),
                      ),
                      Image.asset(
                        AppImage.text_ipad,
                        height: MySize.getHeight(45),
                      ),
                      Image.asset(
                        AppImage.download_ipad,
                        height: MySize.getHeight(45),
                      ),
                      Image.asset(
                        AppImage.Share_Edit_ipad,
                        height: MySize.getHeight(45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
