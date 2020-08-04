import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext ctx) {
    final itemCount = _results?.length ?? 0;

    return itemCount > 0
        ? ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final LogenCode code = _results[index];

              // 앞에 붙이는 ff는 투명도
              final color =
                  Color(int.parse(code.color, radix: 16)).withOpacity(1.0);

              const d = 0.8;
              final leadingStyle = TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFeatures: [FontFeature.tabularFigures()],
                  color: color,
                  fontFamily: 'Monospace',
                  shadows: [
                    Shadow(offset: Offset(-d, -d), color: Colors.black),
                    Shadow(offset: Offset(d, -d), color: Colors.black),
                    Shadow(offset: Offset(d * 2, d * 2), color: Colors.black),
                    Shadow(offset: Offset(-d, d), color: Colors.black),
                  ]);

              return Ink(
                  color: color.withAlpha(90),
                  //color: Colors.white,// Color.fromARGB(255, 0x61, 0x55, 0x32),
                  child: Card(
                      //color: TinyColor(color).brighten(45).color,
                      child: ListTile(
                    title: RichText(
                      text:
                          TextSpan(style: leadingStyle, children: <InlineSpan>[
                        TextSpan(text: '${code.category} ${code.code}'),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            '    ${code.region1}(${code.region2})',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        )
                      ]),
                    ),
                    subtitle: Text(code.area),
                  )));
            },
          )
        : Center(
            child: Text(
              '검색된 지점코드가 없습니다.\n\n택배조회인 경우에는 \n운송장번호 11자리를 입력해주세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          );
  }
}
