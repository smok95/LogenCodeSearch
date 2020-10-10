import 'dart:convert';
import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logencode_flutter/MyColors.dart';

import 'logen_code.dart';

class CodeListView extends StatefulWidget {
  _ListViewState _state = _ListViewState();
  @override
  _ListViewState createState() => _state;

  int filter(String text) {
    return _state.filter(text);
  }
}

class _ListViewState extends State<CodeListView> {
  List<LogenCode> _source = List<LogenCode>();
  List<LogenCode> _results;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/codelist.json').then((value) {
      Map<String, dynamic> jVal = jsonDecode(value);
      if (jVal['data'] != null) {
        for (var json in jVal['data']) {
          var code = LogenCode.fromJson(json);
          _source.add(code);
        }

        setState(() {
          _results = List<LogenCode>.from(_source);
        });
      }
    });
  }

  String _removeHangulJamo(String text) {
    if (text?.isEmpty ?? true) return '';

    final lastIndex = text.length - 1;
    final c = text.codeUnitAt(lastIndex);
    // 문자값이 자음 또는 모음인 경우에는 제외처리
    if (c >= 0x3130 && c <= 0x318f) {
      return text.substring(0, lastIndex);
    }
    return text;
  }

  int filter(String text) {
    _results.clear();

    // 문자열에서 자음/모음 제거
    text = _removeHangulJamo(text);

    setState(() {
      _results = List<LogenCode>.from(_source);

      for (var keyword in text.split(" ")) {
        if (keyword.isEmpty) continue;
        _results.removeWhere((element) => !element.contains(keyword));
      }
    });

    return _results.length;
  }

  Widget _buildCountListView(int count) {
    return Card(
        shadowColor: Colors.transparent, child: Center(child: Text("$count건")));
  }

  Widget _buildListTile(final LogenCode code, final Color color) {
    final leadingStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: color,
        fontFamily: 'Monospace');

    return ListTile(
      dense: true,
      title: Row(children: [
        Expanded(
            child: RichText(
          text: TextSpan(style: leadingStyle, children: <InlineSpan>[
            WidgetSpan(
                child: BorderedText(
                    strokeColor: Colors.grey[800],
                    strokeWidth: 3,
                    child: Text('${code.category} ${code.code}',
                        style: leadingStyle))),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                '   ${code.region1}(${code.region2})',
                style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            )
          ]),
        )),
        Text(
          '${code.branch}',
          style: const TextStyle(color: Colors.black45, fontSize: 13),
        )
      ]),
      subtitle: Text(
        code.area,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildListView(final int itemCount) {
    return DraggableScrollbar.arrows(
        controller: _scrollController,
        backgroundColor: MyColors.backgroundColor,
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: itemCount + 1, // +1은 count 표시
          itemBuilder: (context, index) {
            if (index == itemCount) {
              return _buildCountListView(itemCount);
            }

            final LogenCode code = _results[index];

            // 앞에 붙이는 ff는 투명도
            final color =
                Color(int.parse(code.color, radix: 16)).withOpacity(1.0);

            return Ink(
                color: color.withAlpha(90),
                child: Card(
                    margin: EdgeInsets.all(2),
                    child: _buildListTile(code, color)));
          },
        ));
  }

  @override
  Widget build(BuildContext ctx) {
    final itemCount = _results?.length ?? 0;

    return itemCount > 0
        ? _buildListView(itemCount)
        : Center(
            child: Text(
              '검색된 지점코드가 없습니다.\n\n택배조회인 경우에는 \n운송장번호 11자리를 입력해주세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          );
  }
}
