import 'package:candy_filters/constant/sizeConstant.dart';
import 'package:flutter/material.dart';

class BaseTheme {
  Color get primaryTheme => fromHex("#F9A8B4");
  Color get primaryThemeDark => fromHex("#631380");
  Color get greyColor => fromHex("#E7E7E7");
  Color get lightGreyColor => fromHex("#BDBFC4");
  Color get white => fromHex("#FFFFFF");
  Color get black => fromHex("#000000");
  Color get bottomColor => fromHex("#f05c7f");
  Color get backgroundColor => fromHex("#F9A8B4");
  Color get appBarColor => fromHex("#080A52");
  Color get yellow => Colors.yellow;

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
}

BaseTheme get appTheme => BaseTheme();

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
