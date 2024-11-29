import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';

class BaseTheme {
  Color get primaryTheme => fromHex("#A314D5");
  Color get primaryThemeDark => fromHex("#631380");
  Color get greyColor => fromHex("#E7E7E7");
  Color get lightGreyColor => fromHex("#BDBFC4");
  Color get white => fromHex("#FFFFFF");
  Color get black => fromHex("#000000");
  Color get backgroundDarkColor_020617 => fromHex("#020617");
  Color get testBackgroundColor_64748B => fromHex("#64748B");
  Color get borderColor_E2E8F0 => fromHex("#E2E8F0");
  Color get backgroundColor_F1F5F9 => fromHex("#F1F5F9");
  Color get backgroundColor_EEF2FE => fromHex("#EEF2FE");
  Color get backgroundColor_E2E8F0 => fromHex("#E2E8F0");
  Color get subHeadingColor_334155 => fromHex("#334155");
  Color get cardBackgroundColor_F8FAFC => fromHex("#F3F4F5");
  Color get warningColor => fromHex("#EF4444");
  Color get successColor => fromHex("#10B981");
  Color get black_020617 => fromHex("#020617");
  Color get green_052E16 => fromHex("#052E16");
  Color get green_22C55E => fromHex("#22C55E");
  Color get green_55C25E => fromHex("#55C25E");
  Color get green_10B981 => fromHex("#10B981");
  Color get grey_64748B => fromHex("#64748B");
  Color get grey_94A3B8 => fromHex("#94A3B8");
  Color get grey_E2E8F0 => fromHex("#E2E8F0");
  Color get grey_F3F4F5 => fromHex("#F3F4F5");
  Color get grey_CBD5E1 => fromHex("#CBD5E1");
  Color get purple => fromHex("#A314D5");
  Color get red => fromHex("#EF4444");
  Color get grey_334155 => fromHex("#334155");
  Color get shadowColor_172C41 => fromHex("#172C41");
  Color get orange_F97316 => fromHex("#F97316");
  Color get yellow_F99C21 => fromHex("#F99C21");
  Color get yellow_EAB308 => fromHex("#EAB308");
  Color get yellow_F97316 => fromHex("#F97316");
  Color get red_F4646F => fromHex("#F4646F");
  Color get blue_122B69 => fromHex("#122B69");
  Color get royal_337AB7 => fromHex("#337AB7");

  List<BoxShadow> get getShadow {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black26,
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: appTheme.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(2),
      ),
    ];
  }

  List<BoxShadow> get getShadow3 {
    return [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black12,
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
      BoxShadow(
        offset: Offset(-1, -1),
        color: appTheme.white.withOpacity(0.8),
        blurRadius: MySize.getHeight(0.5),
        spreadRadius: MySize.getHeight(0.5),
      ),
    ];
  }

  List<BoxShadow> get getShadow2 {
    return [
      BoxShadow(
          offset: Offset(MySize.getWidth(2.5), MySize.getHeight(2.5)),
          color: Color(0xffAEAEC0).withOpacity(0.4),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
      BoxShadow(
          offset: Offset(MySize.getWidth(-2.5), MySize.getHeight(-2.5)),
          color: Color(0xffFFFFFF).withOpacity(0.4),
          blurRadius: MySize.getHeight(5),
          spreadRadius: MySize.getHeight(0.2)),
    ];
  }

  LinearGradient get getGradient1 {
    return LinearGradient(
      begin: Alignment(-0.6449, 0.9999),
      end: Alignment(0.1412, -0.4165),
      colors: [
        Color(0xFFFFD363),
        Color(0xFFFF621F),
      ],
      // stops: [0.4234, 0.9996],
      transform: GradientRotation(91.91 * 3.1415 / 180),
    );
  }

  LinearGradient get getGradient {
    return LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xffFF621F),
        Color(0xffFFD363),
      ],
    );
  }

  List<BoxShadow> get decoratedContainerShadow {
    return [
      BoxShadow(
        offset: Offset(0, 0),
        color: blue_122B69.withOpacity(0.08),
        blurRadius: MySize.getHeight(0),
        spreadRadius: MySize.getHeight(1),
      ),
      BoxShadow(
        offset: Offset(0, 1),
        color: blue_122B69.withOpacity(0.08),
        blurRadius: MySize.getHeight(2),
        spreadRadius: MySize.getHeight(0),
      ),
      BoxShadow(
        offset: Offset(0, 2),
        color: blue_122B69.withOpacity(0.04),
        blurRadius: MySize.getHeight(6),
        spreadRadius: MySize.getHeight(0),
      ),
    ];
  }
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
