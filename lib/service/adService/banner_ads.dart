import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gma_mediation_applovin/applovin_mediation_extras.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constant/argumentConstant.dart';

class BannerAdsWidget extends StatefulWidget {
  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;
  bool doYouWantSmallNativeAd = false;
  bool isAdRemoved = false;
  AppLovinMediationExtras applovinExtras =
      AppLovinMediationExtras(isMuted: true);
  @override
  void initState() {
    loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isBannerAdLoaded && !isAdRemoved
          ? Container(
              color: (Colors.white),
              width: bannerAd!.size.width.toDouble(),
              height: bannerAd!.size.height.toDouble(),
              child: AdWidget(
                ad: bannerAd!,
              ),
            )
          : SizedBox(
              height: isAdRemoved ? 0 : 65,
            ),
    );
  }

  void loadBannerAd() async {
    try {
      var size = await anchoredAdaptiveBannerAdSize();
      bannerAd = BannerAd(
        adUnitId: PrefConstant.bannerId,
        size: size ?? AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            print("Banner Ad Loaded");
            setState(() {
              isBannerAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print("Banner Failed to Load : ${error.message}");
            bannerAd!.dispose();
            Future.delayed(Duration(seconds: 5), () {
              loadBannerAd();
            });
          },
        ),
        request: AdRequest(
          mediationExtras: (Platform.isAndroid) ? [] : [applovinExtras],
        ),
      );
      bannerAd!.load();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }
}

Future<AnchoredAdaptiveBannerAdSize?> anchoredAdaptiveBannerAdSize() async {
  return await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(Get.context!).size.width.toInt());
}
