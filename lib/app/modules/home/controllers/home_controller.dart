import 'dart:ui';

import 'package:candy_filters/main.dart';
import 'package:candy_filters/service/adService/ad_service.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

class HomeController extends GetxController {
  RxString profilePhoto = "".obs;
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.rohit.snappy',
    appStoreIdentifier: '1189494806',
  );
  @override
  void onInit() {
    super.onInit();
  }

  openImagePicker({required VoidCallback onTap}) {
    if (box.read("imagePickCount") == 1) {
      box.remove("imagePickCount");
      getIt<AdService>().showInterstitialAd(
        onAdDismissed: onTap,
      );
    } else {
      int imagePickCount = box.read("imagePickCount") ?? 0;
      imagePickCount++;
      box.write("imagePickCount", imagePickCount);
      onTap.call();
    }
  }
}
