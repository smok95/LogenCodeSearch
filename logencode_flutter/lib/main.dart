import 'package:flutter/material.dart';
import 'code_list_view.dart';

void main() => runApp(LogenCodeApp());

class LogenCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로젠택배 지점코드 검색',
      home: HomePage(title: 'Home'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textEditor = TextEditingController();
  var _showClearBtn = false;
  var _codeListview = CodeListView();

  @override
  Widget build(BuildContext ctx) {
    final _iconColor = Colors.brown[100];
    final _hintTextColor = _iconColor;
    final _textColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              Color.fromARGB(255, 0x61, 0x55, 0x32), //Colors.brown,
          titleSpacing: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.search,
                color: _iconColor,
              ),
              onPressed: null),
          title: TextField(
            controller: _textEditor,
            onChanged: (val) {
              _search(val);
            },
            style: TextStyle(color: _textColor),
            decoration: InputDecoration(
                hintText: "검색어를 입력하세요...",
                hintStyle: TextStyle(color: _hintTextColor),
                border: InputBorder.none,
                suffixIcon: _showClearBtn
                    ? IconButton(
                        icon: Icon(Icons.clear, color: _iconColor),
                        onPressed: () {
                          _textEditor.clear();
                          _search('');
                        })
                    : null),
          )),
      body: _codeListview,
    );
  }

  void _search(String keyword) {
    //print("'$keyword'");

    var showClearBtn = keyword.isEmpty ? false : true;

    setState(() {
      _codeListview.filter(keyword);

      if (showClearBtn != _showClearBtn) {
        _showClearBtn = showClearBtn;
      }
    });
  }
}
