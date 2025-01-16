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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
