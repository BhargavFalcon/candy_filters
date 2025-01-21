import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:candy_filters/constant/app_module.dart';
import 'package:flutter/material.dart';
import 'package:gdpr_dialog_flutter/gdpr_dialog_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gma_mediation_applovin/gma_mediation_applovin.dart';
import 'package:gma_mediation_unity/gma_mediation_unity.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/routes/app_pages.dart';

final getIt = GetIt.instance;
GetStorage box = GetStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await GdprDialogFlutter.instance
      .showDialog(isForTest: false, testDeviceId: '')
      .then((onValue) {
    GmaMediationUnity().setGDPRConsent(onValue);
    GmaMediationApplovin().setHasUserConsent(onValue);
  });
  await MobileAds.instance.initialize();
  await GetStorage.init();
  setUp();
  runApp(
    GetMaterialApp(
      title: "Candy Filters",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(0),
          ),
        ),
      ),
    ),
  );
}
