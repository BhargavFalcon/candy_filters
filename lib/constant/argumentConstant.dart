import 'dart:io';

class ArgumentConstant {
  static const pickImage = "pickImage";
  static const iosAccountLink =
      "https://itunes.apple.com/in/developer/rohit-iyer/id1150989827";
  static const androidAccountLink =
      "https://play.google.com/store/apps/dev?id=8336750947549318654";
}

class PrefConstant {
  // Test Ads
  static String bannerId = (Platform.isAndroid)
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-3940256099942544/2934735716";
  static String interAdId = (Platform.isAndroid)
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-3510832308267643/6772022618";
  // // Live Ads
  // static String bannerId = (Platform.isAndroid)
  //     ? "ca-app-pub-3510832308267643/4040559652"
  //     : "ca-app-pub-3510832308267643/1260212617";
  // static String interAdId = (Platform.isAndroid)
  //     ? "ca-app-pub-3510832308267643/5924486962"
  //     : "ca-app-pub-3510832308267643/9321342214";
}
