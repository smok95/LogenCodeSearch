import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:logencode_flutter/logencode_search_page.dart';
import 'package:logencode_flutter/settings_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_admob.dart';
import 'juso_page.dart';
import 'my_local.dart';
import 'my_private_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MyAdmob.initialize();

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
        '/': (context) => _buildHomePage(),
        '/dorojuso': (context) => _buildDaumJusoPage(),
      },
    );
  }

  Widget _buildAdBanner() {
    final banner =
        MyAdmob.createAdmobBanner(adSize: AdmobBannerSize.FULL_BANNER);
    return SizedBox(
      height: banner.adSize.height.toDouble(),
      child: Center(child: banner),
    );
  }

  Widget _buildAdBanner2() {
    final banner =
        MyAdmob.createAdmobBanner2(adSize: AdmobBannerSize.FULL_BANNER);
    return SizedBox(
      height: banner.adSize.height.toDouble(),
      child: Center(child: banner),
    );
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

  Widget _buildDaumJusoPage() {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: JusoPage(title: 'doro')),
          Divider(height: 1, thickness: 1, color: Colors.black),
          _buildAdBanner2(),
        ],
      )),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: LogencodeSearchPage(
                  title: 'Home', onOpenSettings: _onOpenSettings)),
          Divider(height: 1, thickness: 1, color: Colors.black),
          _buildAdBanner(),
        ],
      )),
    );
  }
}
