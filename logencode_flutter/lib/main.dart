import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:little_easy_admob/little_easy_admob.dart';
import 'package:logencode_flutter/logencode_search_page.dart';
import 'package:logencode_flutter/settings_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_admob.dart';
import 'juso_page.dart';
import 'my_local.dart';
import 'my_private_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // AdMob 초기화
  LittleEasyAdmob.initialize(requestTrackingAuthorization: true);

  runApp(LogenCodeApp());
}

class LogenCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateTitle: (BuildContext context) =>
          MyLocal.of(context).text('title'),
      localizationsDelegates: [
        const MyLocalDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', ''),
        const Locale('en', ''),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => _buildHomePage(context),
        '/dorojuso': (context) => _buildDaumJusoPage(context),
      },
    );
  }

  Widget _buildAdBanner(BuildContext context) {
    if (MyPrivateData.hideAd) {
      return SizedBox.shrink();
    }

    final banner = MyAdmob.createAdmobAdaptiveBanner(MyAdmob.unitId, context);
    return Container(color: Colors.grey[50], child: banner);
  }

  Widget _buildAdBanner2(BuildContext context) {
    if (MyPrivateData.hideAd) {
      return SizedBox.shrink();
    }
    final banner = MyAdmob.createAdmobAdaptiveBanner(MyAdmob.unitId2, context);
    return Container(color: Colors.grey[50], child: banner);
  }

  void _onOpenSettings() {
    Get.to(SettingsPage(onSettingChange: (name, value) async {
      if (name == 'share app') {
        Share.share(MyPrivateData.playStoreUrl);
      } else if (name == 'rate review') {
        final playstoreUrl = MyPrivateData.playStoreUrl;
        if (await canLaunch(playstoreUrl)) {
          await launch(playstoreUrl);
        }
      } else if (name == 'more apps') {
        final devPage = MyPrivateData.googlePlayDeveloperPageUrl;
        if (await canLaunch(devPage)) {
          await launch(devPage);
        }
      } else if (name == 'open logen homepage') {
        final iLogen = 'https://www.ilogen.com/m';
        if (await canLaunch(iLogen)) {
          await launch(iLogen);
        }
      }
    }));
  }

  Widget _buildDaumJusoPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(child: JusoPage(title: 'doro')),
              Divider(height: 1, thickness: 1, color: Colors.black),
              _buildAdBanner2(context),
            ],
          )),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
                child: LogencodeSearchPage(
                    title: 'Home', onOpenSettings: _onOpenSettings)),
            Divider(height: 1, thickness: 1, color: Colors.black),
            _buildAdBanner(context),
          ],
        ),
      ),
    );
  }
}
