import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:candy_filters/app/modules/edit_screen/views/imageViewWidget.dart';
import 'package:candy_filters/app/modules/edit_screen/views/textViewWidget.dart';
import 'package:candy_filters/constant/color_constant.dart';
import 'package:candy_filters/constant/image_constants.dart';
import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_screenshot/scroll_screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/edit_screen_controller.dart';

class EditScreenView extends GetView<EditScreenController> {
  const EditScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditScreenController>(
      assignId: true,
      init: EditScreenController(),
      builder: (controller) {
        return Obx(
          () {
            return WillPopScope(
              onWillPop: () async {
                showBackDialog(context: context);
                return false;
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: appTheme.appBarColor,
                  leading: InkWell(
                    onTap: () {
                      showBackDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        AppImage.back,
                      ),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        showBackDialog(
                          context: context,
                          title: "Clear All Changes",
                          subTitle:
                              "Are you sure you want to cle.ar all changes? Please OK to proceed",
                          OkText: "OK",
                          CancelText: "Cancel",
                          onTap: () {
                            controller.stickerList.clear();
                            Get.back();
                          },
                        );
                      },
                      child: Image.asset(
                        AppImage.eraser,
                        height: MySize.getHeight(45),
                      ),
                    ),
                  ],
                  title: Text(
                    'Candy Filters',
                    style: TextStyle(
                      color: appTheme.white,
                      fontSize: MySize.getHeight(18),
                    ),
                  ),
                  centerTitle: true,
                ),
                backgroundColor: appTheme.backgroundColor,
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    RepaintBoundary(
                      key: controller.globalKey,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.file(
                              File(
                                controller.profilePhoto.value,
                              ),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                for (int i = 0;
                                    i < controller.stickerList.length;
                                    i++) {
                                  controller.stickerList[i].isSelected!.value =
                                      false;
                                  controller.stickerList[i].isEdit?.value =
                                      false;
                                }
                                controller.isKeyBordHide.value = false;
                                controller.isFontsVisible.value = false;
                                controller.isColorVisible.value = false;
                              },
                              child: Obx(
                                () => Stack(
                                  children: List.generate(
                                      controller.stickerList.length, (index) {
                                    final data = controller.stickerList[index];
                                    if (isNullEmptyOrFalse(data.offset)) {
                                      data.offset!.value = Offset.zero;
                                    }
                                    return Positioned(
                                      left: data.offset!.value.dx,
                                      top: data.offset!.value.dy,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.stickerList[index]
                                                  .isSelected!.isTrue &&
                                              data.isImage != true) {
                                            controller.stickerList[index]
                                                .isEdit = true.obs;
                                            controller.stickerList.refresh();
                                            data.focusNode!.requestFocus();
                                            controller.update();
                                            controller.isKeyBordHide.value =
                                                false;
                                          } else {
                                            for (int i = 0;
                                                i <
                                                    controller
                                                        .stickerList.length;
                                                i++) {
                                              controller
                                                  .stickerList[i]
                                                  .isSelected!
                                                  .value = i == index;
                                            }
                                          }
                                        },
                                        onPanUpdate: (details) {
                                          if (data.isSelected!.isTrue) {
                                            data.offset!.value = Offset(
                                                data.offset!.value.dx +
                                                    details.delta.dx,
                                                data.offset!.value.dy +
                                                    details.delta.dy);
                                          }
                                        },
                                        child: Container(
                                          height: MySize.getHeight(400),
                                          width: MySize.getWidth(360),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: (data.isImage ?? false)
                                                  ? ImageViewWidget(
                                                      title: data.title!,
                                                      onTap: () {
                                                        controller.stickerList
                                                            .removeWhere(
                                                                (item) {
                                                          return item.uid ==
                                                              data.uid;
                                                        });
                                                      },
                                                      fontSize: data.fontSize,
                                                      isSelect: data
                                                          .isSelected!.value)
                                                  : TextViewWidget(
                                                      title: data.title!,
                                                      onTap: () {
                                                        controller.stickerList
                                                            .removeWhere(
                                                                (item) {
                                                          return item.uid ==
                                                              data.uid;
                                                        });
                                                      },
                                                      isEdit:
                                                          data.isEdit?.value ??
                                                              false,
                                                      isSelect: data
                                                          .isSelected!.value,
                                                      fontSize: data.fontSize,
                                                      opacity: data.opacity,
                                                      fontFamily:
                                                          data.fontFamily,
                                                      fontColor: data.fontColor,
                                                      focusNode: data.focusNode,
                                                      showBackground:
                                                          data.showBackground,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: (controller.isStickerVisible.isTrue)
                          ? Container(
                              color: Colors.black.withOpacity(.5),
                              child: GridView.builder(
                                itemCount: controller
                                    .emojiList[controller.stickerIndex.value]
                                    .numberOfStickers,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  String char = controller
                                      .emojiList[controller.stickerIndex.value]
                                      .char!;
                                  String imagePath =
                                      "${stickersImagePath}${controller.stickerIndex.value + 1}/${char}${index + 1}.png";
                                  return InkWell(
                                    onTap: () {
                                      controller.isStickerVisible.value = false;
                                      controller.stickerList.add(TextListModel(
                                        title: TextEditingController(
                                            text: imagePath),
                                        isSelected: true.obs,
                                        isEdit: false.obs,
                                        isImage: true,
                                        uid: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()
                                            .obs,
                                        offset: Offset.zero.obs,
                                        rotationAngle: 0.0.obs,
                                        fontSize: 2.0.obs,
                                        opacity: 1.0.obs,
                                        fontFamily: "PoetsenOne".obs,
                                        fontColor: Colors.white.obs,
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        imagePath,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
                bottomSheet: (controller.stickerList
                        .any((element) => element.isEdit?.isTrue ?? false))
                    ? Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 50,
                              color: appTheme.appBarColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.isKeyBordHide.isTrue) {
                                        int index = controller.stickerList
                                            .indexWhere((element) =>
                                                element.isEdit?.isTrue ??
                                                false);

                                        // Check if there's an element in edit mode, then request focus
                                        if (index != -1 &&
                                            controller.stickerList[index]
                                                    .focusNode !=
                                                null) {
                                          controller
                                              .stickerList[index].focusNode!
                                              .requestFocus();
                                        }

                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.show');
                                        controller.isKeyBordHide.value = false;
                                        controller.isFontsVisible.value = false;
                                        controller.isColorVisible.value = false;
                                      } else {
                                        controller.isKeyBordHide.value = true;
                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.hide');
                                      }
                                    },
                                    child: SizedBox(
                                      height: MySize.getHeight(50),
                                      width: MySize.getHeight(50),
                                      child: Icon(
                                        Icons.keyboard,
                                        color:
                                            (controller.isKeyBordHide.isFalse)
                                                ? appTheme.yellow
                                                : appTheme.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isKeyBordHide.value = true;

                                      controller.isFontsVisible.value = true;
                                      controller.isColorVisible.value = false;
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                    child: Container(
                                      height: MySize.getHeight(50),
                                      width: MySize.getHeight(50),
                                      child: Icon(
                                        CupertinoIcons.textformat_alt,
                                        color:
                                            (controller.isFontsVisible.isTrue)
                                                ? Colors.yellow
                                                : appTheme.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isKeyBordHide.value = true;
                                      controller.isFontsVisible.value = false;
                                      controller.isColorVisible.value = true;
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                    child: Container(
                                      height: MySize.getHeight(50),
                                      width: MySize.getHeight(50),
                                      child: Icon(
                                        Icons.color_lens,
                                        color:
                                            (controller.isColorVisible.isTrue)
                                                ? Colors.yellow
                                                : appTheme.white,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isKeyBordHide.value = false;
                                      controller.stickerList.forEach((element) {
                                        element.isEdit?.value = false;
                                        element.isSelected!.value = false;
                                      });
                                    },
                                    child: Container(
                                      height: MySize.getHeight(50),
                                      width: MySize.getHeight(50),
                                      child: Icon(
                                        CupertinoIcons.check_mark,
                                        color: appTheme.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.isKeyBordHide.isTrue)
                              Container(
                                height: MySize.getHeight(250),
                                color: Colors.white,
                                child: (controller.isFontsVisible.isTrue)
                                    ? GridView.builder(
                                        itemCount:
                                            controller.fontFamilyNames.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                        ),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              int i = controller.stickerList
                                                  .indexWhere((element) =>
                                                      element
                                                          .isSelected!.isTrue);
                                              controller.stickerList[i]
                                                      .fontFamily!.value =
                                                  controller
                                                      .fontFamilyNames[index];
                                              print(controller.stickerList[i]
                                                  .fontFamily!.value);
                                            },
                                            child: Center(
                                              child: Text(
                                                "ABC",
                                                style: TextStyle(
                                                    fontSize:
                                                        MySize.getHeight(18),
                                                    color: appTheme.black,
                                                    fontFamily: controller
                                                            .fontFamilyNames[
                                                        index]),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Builder(builder: (context) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onPanUpdate: (details) async {
                                            final RenderBox box =
                                                context.findRenderObject()
                                                    as RenderBox;
                                            final Offset position =
                                                box.globalToLocal(
                                                    details.globalPosition);
                                            await controller.pickColor(
                                              image: controller.image!,
                                              position: position,
                                              widgetSize: box.size,
                                            );
                                          },
                                          child: Container(
                                            height: MySize.getHeight(200),
                                            color: Colors.white,
                                            child: Image.asset(
                                              AppImage.colorBar,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      }),
                              )
                          ],
                        ),
                      )
                    : null,
                bottomNavigationBar: (controller.stickerList
                        .any((element) => element.isEdit?.value ?? false))
                    ? null
                    : Visibility(
                        visible: controller.isKeyBordHide.isFalse,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: MySize.getHeight(50),
                                  decoration: BoxDecoration(
                                    color: appTheme.white,
                                  ),
                                ),
                                Spacing.height(100)
                              ],
                            ),
                            if (controller.isStickerVisible.value)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: MySize.getHeight(50),
                                    decoration: BoxDecoration(
                                      color: appTheme.bottomColor,
                                      border: Border(
                                        top: BorderSide(
                                            color: appTheme.appBarColor,
                                            width: 5),
                                      ),
                                    ),
                                    child: ListView.separated(
                                      padding: EdgeInsets.all(10),
                                      itemCount: 22,
                                      scrollDirection: Axis.horizontal,
                                      controller: controller.scrollController,
                                      itemBuilder: (context, index) {
                                        return Obx(() {
                                          return InkWell(
                                            focusNode:
                                                controller.focusNodes[index],
                                            onTap: () {
                                              controller.stickerIndex.value =
                                                  index;
                                              controller.stickerIndex.refresh();
                                              controller.update();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                border: (controller.stickerIndex
                                                            .value ==
                                                        index)
                                                    ? Border.all(
                                                        color: appTheme
                                                            .appBarColor,
                                                      )
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Image.asset(
                                                "${categoryImagePath}Cat_${index + 1}.png",
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      separatorBuilder: (context, index) {
                                        return Spacing.width(15);
                                      },
                                    ),
                                  ),
                                  Spacing.height(100)
                                ],
                              ),
                            Container(
                              height: MySize.getHeight(100),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.bottom),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.stickerList.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                      controller.isStickerVisible.toggle();
                                      if (controller.isStickerVisible.isTrue)
                                        Future.delayed(
                                            Duration(milliseconds: 100), () {
                                          double offset =
                                              controller.stickerIndex.value *
                                                  25.0;
                                          print(offset);
                                          controller.scrollController.animateTo(
                                            offset,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        });
                                    },
                                    child: Image.asset(
                                      AppImage.smile,
                                      height: MySize.getHeight(45),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.stickerList.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                      controller.isStickerVisible.value = false;
                                      controller.stickerList.add(TextListModel(
                                        title: TextEditingController(
                                            text: "Type Here"),
                                        isSelected: true.obs,
                                        isEdit: false.obs,
                                        focusNode: FocusNode(),
                                        uid: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()
                                            .obs,
                                        offset: Offset.zero.obs,
                                        rotationAngle: 0.0.obs,
                                        fontSize: 2.0.obs,
                                        opacity: 1.0.obs,
                                        fontFamily: "PoetsenOne".obs,
                                        fontColor: Colors.white.obs,
                                        showBackground: true,
                                      ));
                                    },
                                    child: Image.asset(
                                      AppImage.text,
                                      height: MySize.getHeight(25),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.stickerList.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                      controller.isStickerVisible.value = false;
                                      controller.stickerList.add(TextListModel(
                                        title: TextEditingController(
                                            text: "Type Here"),
                                        isSelected: true.obs,
                                        isEdit: false.obs,
                                        focusNode: FocusNode(),
                                        uid: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString()
                                            .obs,
                                        offset: Offset.zero.obs,
                                        rotationAngle: 0.0.obs,
                                        fontSize: 2.0.obs,
                                        opacity: 1.0.obs,
                                        fontFamily: "PoetsenOne".obs,
                                        fontColor: Colors.white.obs,
                                      ));
                                    },
                                    child: Image.asset(
                                      AppImage.text_ipad,
                                      height: MySize.getHeight(45),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showCircularDialog(Get.context!);

                                      controller.stickerList.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                      String? base64String =
                                          await ScrollScreenshot
                                              .captureAndSaveScreenshot(
                                                  controller.globalKey);

                                      if (base64String == null) {
                                        log("Screenshot failed.");
                                        hideCircularDialog(Get.context!);
                                        Fluttertoast.showToast(
                                          msg:
                                              "Something went wrong please try again",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        return;
                                      }
                                      final bytes = base64Decode(base64String);
                                      controller.downloadImage(image: bytes);
                                    },
                                    child: Image.asset(
                                      AppImage.download_ipad,
                                      height: MySize.getHeight(45),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showCircularDialog(Get.context!);

                                      controller.stickerList.forEach((element) {
                                        element.isSelected!.value = false;
                                      });
                                      String? base64String =
                                          await ScrollScreenshot
                                              .captureAndSaveScreenshot(
                                                  controller.globalKey);

                                      if (base64String == null) {
                                        log("Screenshot failed.");
                                        hideCircularDialog(Get.context!);
                                        Fluttertoast.showToast(
                                          msg:
                                              "Something went wrong please try again",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        return;
                                      }
                                      final bytes = base64Decode(base64String);

                                      final directory =
                                          await getApplicationCacheDirectory();
                                      final imagePath = File(
                                          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
                                      await imagePath.writeAsBytes(bytes);

                                      hideCircularDialog(context);
                                      await Share.shareXFiles(
                                        [XFile(imagePath.path)],
                                        subject: "Candy Filters",
                                      );
                                    },
                                    child: Image.asset(
                                      AppImage.Share_Edit_ipad,
                                      height: MySize.getHeight(45),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  showBackDialog({
    required BuildContext context,
    String title = "Are you sure you want to cancel editing?",
    String? subTitle,
    VoidCallback? onTap,
    String OkText = "Yes",
    String CancelText = "No",
  }) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (context) {
        return CupertinoTheme(
          data: CupertinoThemeData(brightness: Brightness.dark),
          child: CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontSize: MySize.getHeight(20),
                color: appTheme.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'ChampagneLimousines',
              ),
            ),
            content: (subTitle == null)
                ? null
                : Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: MySize.getHeight(15),
                      fontWeight: FontWeight.w600,
                      color: appTheme.white,
                      fontFamily: 'ChampagneLimousines',
                    ),
                  ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  CancelText,
                  style: TextStyle(
                    fontSize: MySize.getHeight(16),
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ChampagneLimousines',
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  OkText,
                  style: TextStyle(
                    fontSize: MySize.getHeight(16),
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ChampagneLimousines',
                  ),
                ),
                onPressed: onTap ??
                    () {
                      Get.back();
                      Get.back();
                    },
              ),
            ],
          ),
        );
      },
    );
  }
}
