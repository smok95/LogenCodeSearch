import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'parcel_tracking_vew.dart';
import 'code_list_view.dart';
import 'daum_address.dart';

final backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);

class LogencodeSearchPage extends StatefulWidget {
  /// 설정창 열기 이벤트
  final VoidCallback onOpenSettings;

  LogencodeSearchPage({Key key, this.title, this.onOpenSettings})
      : super(key: key);
  final String title;

  _LogencodeSearchPageState createState() => _LogencodeSearchPageState();
}

class _LogencodeSearchPageState extends State<LogencodeSearchPage> {
  var _textEditor = TextEditingController();
  var _showClearBtn = false;
  var _codeListview = CodeListView();

  @override
  Widget build(BuildContext ctx) {
    final iconColor = Colors.brown[100];

    //final body = _trackingNumber.isEmpty ? _codeListview : _buildTrackingView();
    final index = _trackingNumber.isEmpty ? 0 : 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor, //Colors.brown,
        titleSpacing: 5.0,
        title: _buildSearchBar(),
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert, color: iconColor),
              onPressed: widget.onOpenSettings),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: [_codeListview, _buildTrackingView()],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
            backgroundColor: backColor,
            onPressed: () {
              // Scaffold.of(context).hideCurrentSnackBar();
              _navigateAndSearchAddress(context);
            },
            tooltip: '도로명주소 검색',
            label: Text('도로명 검색'),
            icon: Icon(Icons.search));
      }),
    );
  }

  Widget _buildTrackingView() {
    return _trackingNumber.isEmpty
        ? Center(child: Text('운송장번호를 입력해주세요'))
        : ParcelTrackingView(_trackingNumber);
  }

  Widget _buildSearchBar() {
    final iconColor = Colors.brown[100];
    final hintTextColor = iconColor;
    final textColor = Colors.white;

    return TextField(
      controller: _textEditor,
      onChanged: _search,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          filled: true,
          fillColor: Colors.white12,
          prefixIcon: Icon(Icons.search, color: iconColor),
          //border: InputBorder.none,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: "주소 또는 송장번호를 입력하세요",
          hintStyle: TextStyle(color: hintTextColor),
          suffixIcon: _showClearBtn
              ? IconButton(
                  icon: Icon(Icons.clear, color: iconColor),
                  onPressed: () {
                    _textEditor.clear();
                    _search('');
                  })
              : null),
    );
  }

  void _snackbar(BuildContext context, String title, String subtitle) {
    final snackBar = SnackBar(
      action: SnackBarAction(
          label: "닫기",
          onPressed: () => Scaffold.of(context).hideCurrentSnackBar()),
      duration: Duration(seconds: 15),
      content: Wrap(
        children: <Widget>[
          new ListTile(
              title: Text(title), subtitle: Text(subtitle), onTap: () => {}),
        ],
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _navigateAndSearchAddress(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _snackbar(context, '네트워크 오류',
          '연결된 네트워크가 없습니다. 모바일(3G/LTE/5G) 또는 와이파이 연결상태를 확인해주세요.');
      return;
    }

    final value = await Navigator.pushNamed(context, '/dorojuso');
    if (value != null) {
      _searchFromDaumAddress(context, value);
    }

    FocusScope.of(context).unfocus();
  }

  void _searchFromDaumAddress(BuildContext context, String src) {
    if (src == null) return;

    Map<String, dynamic> data = jsonDecode(src);
    if (data == null) return null;

    var items = DaumAddress.convertFrom(data);

    String keyword = '';
    String tempKeyword = '';
    for (var item in items) {
      if (item == null || item.name.isEmpty) continue;
      tempKeyword += item.name + ' ';
      final count = _codeListview.filter(tempKeyword);
      if (count > 0) {
        keyword += item.name;
        if (keyword.length > 0) keyword += ' ';
      } else {
        break;
      }
    }
    _textEditor.text = keyword;
    _search(_textEditor.text);

    // 도로명주소
    String roadAddr = data['roadAddress'];
    if (roadAddr.isEmpty) roadAddr = data['autoRoadAddress'];

    // 지번주소
    String jibunAddr = data['jibunAddress'];
    if (jibunAddr.isEmpty) jibunAddr = data['autoJibunAddress'];

    _snackbar(context, '검색결과', '도로명: $roadAddr\n지번: $jibunAddr');
  }

  List _isTrackingNumber(String value) {
    if (value == null) return [false, value];

    // 공백제거
    value = value.replaceAll(' ', '');

    // 로젠택배 운송자번호는 11자리 숫자임.
    if (value.length != 11) return [false, value];

    final isNumber = int.tryParse(value) != null;
    return [isNumber, value];
    //https: //www.ilogen.com/web/personal/trace/95825729134
  }

  bool _isNumber(final String value) {
    if (value == null) return false;
    return int.tryParse(value) != null;
  }

  void _search(String keyword) {
    //print("'$keyword'");

    var showClearBtn = keyword.isEmpty ? false : true;

    setState(() {
      final result = _isTrackingNumber(keyword);

      if (result[0] == true) {
        _trackingNumber = result[1];
        _textEditor.text = _trackingNumber;
        FocusScope.of(context).unfocus();
      } else {
        _trackingNumber = '';
        _codeListview.filter(keyword);
      }

      if (showClearBtn != _showClearBtn) {
        _showClearBtn = showClearBtn;
      }
    });
  }

  String _trackingNumber = '';
}
