import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 2020.10.09 일단 보류
class BoardPage extends StatefulWidget {
  final String title;
  BoardPage({Key key, this.title}) : super(key: key);

  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext ctx) {
    return _buildWebview(ctx);
  }

  Widget _buildWebview(BuildContext ctx) {
    final _backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);
    final url = 'https://logencode.modoo.at/?link=o7aiqonm';
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: const ListTile(
            title: Text(
          '게시판',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: _backColor,
      ),
      withZoom: true,
      withLocalStorage: true,
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
