import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logencode_flutter/controller/search_controller.dart';
import 'package:logencode_flutter/model/logen_code.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'parcel_tracking_vew.dart';
import 'code_list_view.dart';
import 'daum_address.dart';

final backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);

/// 로젠택배 지점코드 검색 페이지
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
  final _controller = SearchController();
  var _result = <LogenCode>[];

  @override
  void initState() {
    super.initState();

    _controller.initialize().whenComplete(() {
      setState(() {
        _result = _controller.data;
      });
    });
  }

  @override
  Widget build(BuildContext ctx) {
    final iconColor = Colors.brown[100];
    final index = _trackingNumber.isEmpty ? 0 : 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor,
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
        children: [
          _buildCodeListView(),
          _buildTrackingView(),
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
            backgroundColor: backColor,
            onPressed: () {
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

  Widget _buildCodeListView() {
    if (_result.isEmpty) {
      return Center(
        child: Text(
          '검색된 지점코드가 없습니다.\n\n택배조회인 경우에는 \n운송장번호 11자리를 입력해주세요',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
    } else {
      return CodeListView(_result);
    }
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
    final textStyle = TextStyle(color: Colors.white);
    final snackBar = SnackBar(
      action: SnackBarAction(
          label: "닫기",
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      duration: Duration(seconds: 15),
      content: Wrap(
        children: <Widget>[
          ListTile(
              title: Text(
                title,
                style: textStyle,
              ),
              subtitle: Text(
                subtitle,
                style: textStyle,
              ),
              onTap: () => {}),
        ],
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

      final result = _controller.search(tempKeyword);
      if (result.length > 0) {
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

  /// 검색
  void _search(String keyword) {
    var showClearBtn = keyword.isEmpty ? false : true;

    setState(() {
      final result = _isTrackingNumber(keyword);

      if (result[0] == true) {
        _trackingNumber = result[1];
        _textEditor.text = _trackingNumber;
        FocusScope.of(context).unfocus();
      } else {
        _trackingNumber = '';
        _result = _controller.search(keyword);
      }

      if (showClearBtn != _showClearBtn) {
        _showClearBtn = showClearBtn;
      }
    });
  }

  String _trackingNumber = '';
}
