import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class JusoPage extends StatefulWidget {
  final String title;
  JusoPage({Key key, this.title}) : super(key: key);

  _JusoPageState createState() => _JusoPageState();
}

class _JusoPageState extends State<JusoPage> {
  @override
  Widget build(BuildContext ctx) {
    final _backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);
    final url = 'https://smok95.github.io/LogenCodeSearch';
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: const ListTile(
            title: Text(
              '도로명주소 검색',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '▼ 아래 검색란에 입력하세요',
              style: TextStyle(color: Colors.white70),
            )),
        backgroundColor: _backColor,
      ),
      withZoom: true,
      withLocalStorage: true,
      javascriptChannels: Set.from([
        JavascriptChannel(
          name: 'flutter',
          onMessageReceived: (message) {
            Navigator.pop(ctx, message.message);
            //_webviewPlugin.close();
          },
        ),
      ]),
      // hidden: true,
      initialChild: Container(
        color: Colors.grey,
        child: const Center(
          child: Text('연결중...'),
        ),
      ),
    );
  }
}
