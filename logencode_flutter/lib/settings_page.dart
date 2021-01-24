import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';

import 'my_local.dart';

const String aboutText = '''
로젠택배 전국 지점의 지점코드를 검색하는 앱입니다.

해당 앱은 로젠택배사와 관계가 없으며, 검색결과는 참고용입니다.
검색결과의 오류로 인해 발생하는 문제에 책임을 지지 않으니 주의 부탁드립니다.
''';

final backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);

typedef DarkModeCallback = void Function(bool darkMode);
typedef SettingChangeCallback = void Function(String name, dynamic value);

class SettingsPage extends StatelessWidget {
  final DarkModeCallback onToggleDarkMode;
  final SettingChangeCallback onSettingChange;

  SettingsPage({this.onToggleDarkMode, this.onSettingChange});

  void _fireChange(final String name, dynamic value) {
    if (onSettingChange != null) {
      onSettingChange(name, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lo = MyLocal.of(context).text;

    final tiles = List<SettingsTile>();

    if (Platform.isAndroid) {
      tiles.add(SettingsTile(
          leading: Icon(Icons.rate_review),
          title: lo('rate review'),
          onPressed: (_) {
            _fireChange('rate review', null);
          }));

      tiles.add(
        SettingsTile(
            leading: Icon(Icons.share),
            title: lo('share app'),
            onPressed: (_) {
              _fireChange('share app', null);
            }),
      );

      tiles.add(
        SettingsTile(
            leading: Icon(Icons.apps),
            title: lo('more apps'),
            onPressed: (_) {
              _fireChange('more apps', null);
            }),
      );
    }

    tiles.add(
      SettingsTile(
        leading: Icon(Icons.open_in_browser),
        title: '로젠택배 홈페이지',
        onPressed: (_) => _fireChange('open logen homepage', null),
      ),
    );

    tiles.add(SettingsTile(
      leading: Icon(Icons.info_outline),
      title: lo('app info'),
      onPressed: (_) async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        showAboutDialog(
            context: context,
            applicationName: packageInfo.appName,
            applicationVersion: packageInfo.version,
            children: [Text(aboutText)]);
      },
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(lo('settings')),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: tiles),
        ],
      ),
    );
  }
}
