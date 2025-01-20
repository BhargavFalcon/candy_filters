import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gma_mediation_applovin/applovin_mediation_extras.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constant/argumentConstant.dart';

class AdService {
  InterstitialAd? interstitialAds;
  void showInterstitialAd(
      {VoidCallback? onAdDismissed, bool isFromFav = false}) {
    interstitialAds?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) =>
          print('Ad showed fullscreen content.'),
      onAdDismissedFullScreenContent: (ad) {
        onAdDismissed?.call();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        interstitialAds?.dispose();
        interstitialAds = null;
        loadInterstitialAd();
        print('Ad dismissed fullscreen content.');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad failed to show fullscreen content: $error');
      },
    );

    if (interstitialAds == null) {
      onAdDismissed?.call();
    }
    interstitialAds?.show().then((value) =>
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []));
  }

  AppLovinMediationExtras applovinExtras =
      AppLovinMediationExtras(isMuted: true);
  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: PrefConstant.interAdId,
      request: AdRequest(
        mediationExtras: (Platform.isAndroid) ? [] : [applovinExtras],
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAds = ad;
          print("InterstitialAd loaded.");
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
          Future.delayed(Duration(seconds: 5), () {
            loadInterstitialAd();
          });
        },
      ),
    );
  }
}
