import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_constant.dart';
import 'image_constants.dart';

class MySize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late bool isMini;
  static double? safeWidth;
  static double? safeHeight;

  static late double scaleFactorWidth;
  static late double scaleFactorHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    isMini = _mediaQueryData.size.height < 750;
    double _safeAreaWidth =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double _safeAreaHeight =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeWidth = (screenWidth - _safeAreaWidth);
    safeHeight = (screenHeight - _safeAreaHeight);

    safeWidth = (screenWidth - _safeAreaWidth);
    safeHeight = (screenHeight - _safeAreaHeight);

    scaleFactorHeight = (safeHeight! / 868);
    if (scaleFactorHeight < 1) {
      double diff = (1 - scaleFactorHeight) * (1 - scaleFactorHeight);
      scaleFactorHeight += diff;
    }

    scaleFactorWidth = (safeWidth! / 375);

    if (scaleFactorWidth < 1) {
      double diff = (1 - scaleFactorWidth) * (1 - scaleFactorWidth);
      scaleFactorWidth += diff;
    }
  }

  static double getWidth(double size) {
    return (size * scaleFactorWidth);
  }

  static double getHeight(double size) {
    return (size * scaleFactorHeight);
  }
}

class Spacing {
  static EdgeInsetsGeometry zero = EdgeInsets.zero;

  static EdgeInsetsGeometry only(
      {double top = 0, double right = 0, double bottom = 0, double left = 0}) {
    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

  static EdgeInsetsGeometry fromLTRB(
      double left, double top, double right, double bottom) {
    return Spacing.only(bottom: bottom, top: top, right: right, left: left);
  }

  static EdgeInsetsGeometry all(double spacing) {
    return Spacing.only(
        bottom: spacing, top: spacing, right: spacing, left: spacing);
  }

  static EdgeInsetsGeometry left(double spacing) {
    return Spacing.only(left: spacing);
  }

  static EdgeInsetsGeometry nLeft(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing, right: spacing);
  }

  static EdgeInsetsGeometry top(double spacing) {
    return Spacing.only(top: spacing);
  }

  static EdgeInsetsGeometry nTop(double spacing) {
    return Spacing.only(left: spacing, bottom: spacing, right: spacing);
  }

  static EdgeInsetsGeometry right(double spacing) {
    return Spacing.only(right: spacing);
  }

  static EdgeInsetsGeometry nRight(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing, left: spacing);
  }

  static EdgeInsetsGeometry bottom(double spacing) {
    return Spacing.only(bottom: spacing);
  }

  static EdgeInsetsGeometry nBottom(double spacing) {
    return Spacing.only(top: spacing, left: spacing, right: spacing);
  }

  static EdgeInsetsGeometry horizontal(double spacing) {
    return Spacing.only(left: spacing, right: spacing);
  }

  static x(double spacing) {
    return Spacing.only(left: spacing, right: spacing);
  }

  static xy(double xSpacing, double ySpacing) {
    return Spacing.only(
        left: xSpacing, right: xSpacing, top: ySpacing, bottom: ySpacing);
  }

  static y(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing);
  }

  static EdgeInsetsGeometry vertical(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing);
  }

  static EdgeInsetsGeometry symmetric(
      {double vertical = 0, double horizontal = 0}) {
    return Spacing.only(
        top: vertical, right: horizontal, left: horizontal, bottom: vertical);
  }

  static Widget height(double height) {
    return SizedBox(
      height: height,
    );
  }

  static Widget width(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget topHeight(double height) {
    return Container(
      color: appTheme.white,
      height: height,
    );
  }
}

class Space {
  Space();

  static Widget height(double space) {
    return SizedBox(
      height: MySize.getHeight(space),
    );
  }

  static Widget width(double space) {
    return SizedBox(
      width: MySize.getHeight(space),
    );
  }
}

enum ShapeTypeFor { container, button }

class Shape {
  static dynamic circular(double radius,
      {ShapeTypeFor shapeTypeFor = ShapeTypeFor.container}) {
    BorderRadius borderRadius =
        BorderRadius.all(Radius.circular(MySize.getHeight(radius)));

    switch (shapeTypeFor) {
      case ShapeTypeFor.container:
        return borderRadius;
      case ShapeTypeFor.button:
        return RoundedRectangleBorder(borderRadius: borderRadius);
    }
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

// CachedNetworkImage getImageByLink({
//   required String url,
//   required double height,
//   required double width,
//   bool isLoading = false,
//   bool colorFilter = false,
//   String imagePlaceHolder = AppImage.,
//   BoxFit boxFit = BoxFit.cover,
//   Widget? image,
//   BorderRadiusGeometry? borderRadius,
//   Color? errorColor,
// }) {
//   return CachedNetworkImage(
//     imageUrl: url,
//     imageBuilder: (context, imageProvider) => Container(
//       height: MySize.getHeight(height),
//       width: MySize.getHeight(width),
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: imageProvider,
//           fit: boxFit,
//           colorFilter: (colorFilter)
//               ? ColorFilter.mode(
//                   Colors.black.withOpacity(0.6), BlendMode.darken)
//               : null,
//         ),
//         borderRadius: borderRadius ?? BorderRadius.circular(0),
//       ),
//     ),
//     errorListener: (value) {
//       print(value);
//     },
//     placeholder: (context, url) => (isLoading)
//         ? image ??
//             Image(
//                 image: AssetImage(imagePlaceHolder),
//                 height: MySize.getHeight(height),
//                 width: MySize.getHeight(width),
//                 fit: BoxFit.contain)
//         : Container(
//             height: MySize.getHeight(height),
//             width: MySize.getHeight(width),
//             decoration: BoxDecoration(
//               borderRadius: borderRadius ?? BorderRadius.circular(0),
//             ),
//             child: LinearProgressIndicator(
//               color: Colors.grey.shade200,
//               backgroundColor: Colors.grey.shade100,
//             ),
//           ),
//     errorWidget: (context, url, error) =>
//         image ??
//         Image(
//           image: AssetImage(imagePlaceHolder),
//           height: MySize.getHeight(height),
//           width: MySize.getHeight(width),
//           fit: BoxFit.contain,
//           color: errorColor ?? null,
//         ),
//   );
// }

void hideCircularDialog(BuildContext context) {
  Get.back();
}

void showCircularDialog(BuildContext context) {
  CircularDialog.showLoadingDialog(context);
}

class CircularDialog {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent.withOpacity(0.1),
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back button press
          child: Scaffold(
            backgroundColor: Colors.transparent.withOpacity(0.1),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.getHeight(10)),
                    child: Image.asset(
                      AppImage.loadGif,
                      height: MySize.getHeight(100),
                    ),
                  ),
                  Space.height(5),
                  Text(
                    "Loading Sticker...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MySize.getHeight(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

urlLauncher({required Uri url, String name = "", String? error}) async {
  try {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    print(e);
    await getDialog(
        title: "Error", desc: error ?? "Unable to find $name in your device");
  }
}

getDialog(
    {String title = "Error",
    String desc = "Some Thing went wrong....",
    Callback? onTap}) {
  return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      content: Center(
        child: Text(desc, textAlign: TextAlign.center),
      ),
      buttonColor: appTheme.primaryTheme,
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: (isNullEmptyOrFalse(onTap))
          ? () {
              Get.back();
            }
          : onTap);
}
