import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:admob_flutter/admob_flutter.dart';
import 'my_private_data.dart';

class MyAdmob {
  /// {@template firebase_admob.testAdUnitId}
  /// A platform-specific AdMob test ad unit ID. This ad unit
  /// has been specially configured to always return test ads, and developers
  /// are encouraged to use it while building and testing their apps.
  /// {@endtemplate}
  /// {@macro firebase_admob.testAdUnitId}
  /// [package:firebase_admob/firebase_admob.dart]에서 발췌함.
  static final String testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static String get appId => MyPrivateData.adMobAppId;
  static String get unitId {
    if (Foundation.kDebugMode) {
      return testAdUnitId;
    } else {
      return Platform.isAndroid
          ? MyPrivateData.adMobUnitId1AOS
          : MyPrivateData.adMobUnitId1IOS;
    }
  }

  static String get unitId2 {
    if (Foundation.kDebugMode) {
      return testAdUnitId;
    } else {
      return Platform.isAndroid
          ? MyPrivateData.admobUnitId2AOS
          : MyPrivateData.adMobUnitId1IOS;
    }
  }

  /// Admob 배너 생성
  static AdmobBanner createAdmobBanner(
      {AdmobBannerSize adSize = AdmobBannerSize.FULL_BANNER}) {
    return AdmobBanner(adUnitId: unitId, adSize: adSize);
  }

  static AdmobBanner createAdmobBanner2(
      {AdmobBannerSize adSize = AdmobBannerSize.FULL_BANNER}) {
    return AdmobBanner(adUnitId: unitId2, adSize: adSize);
  }

  /// Admob Adaptive 배너 생성
  static AdmobBanner createAdmobAdaptiveBanner(
      String unitId, BuildContext context) {
    final width = MediaQuery.of(context).size.width.toInt();
    final adSize = AdmobBannerSize.ADAPTIVE_BANNER(width: width);
    print("createAdmobAdaptiveBanner, unitId=$unitId");
    return AdmobBanner(adUnitId: unitId, adSize: adSize);
  }

  // Adaptive, Smart Banner와 같이 크기가 고정이 아닌 배너의 크기를 구한다.
  static Future<Size> getBannerSize(AdmobBannerSize admobBannerSize) async {
    return await Admob.bannerSize(admobBannerSize);
  }

  /// 화면크기에 맞는 배너 높이값을 구한다.
  double getSmartBannerHeight(BuildContext context) {
    // 참고페이지 : https://stackoverflow.com/questions/50935918/how-to-get-banner-size-of-smart-banner

    MediaQueryData mediaScreen = MediaQuery.of(context);
    double deviceHeight = mediaScreen.orientation == Orientation.portrait
        ? mediaScreen.size.height
        : mediaScreen.size.width;

    if (deviceHeight <= 400.0) {
      return 32.0;
    } else if (deviceHeight > 720.0) {
      return 90.0;
    } else {
      return 50.0;
    }
  }
}
