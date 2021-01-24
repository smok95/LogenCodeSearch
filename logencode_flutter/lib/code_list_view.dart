import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'MyColors.dart';
import 'model/logen_code.dart';

class CodeListView extends StatefulWidget {
  final List<LogenCode> data;
  CodeListView(this.data, {Key key}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<CodeListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
        fontFeatures: [FontFeature.tabularFigures()],
        fontFamily: Platform.isIOS ? 'Menlo' : 'Monospace');

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
                    fontFeatures: [FontFeature.tabularFigures()],
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
    /// item 개수가 최소 4개 이상일때부터 DraggableScrollbar를 사용한다.
    /// iOS에서 'haveDimensions == (_lastMetrics != null)': is not true.
    /// 오류에 대한 회피책.

    final scrollController = itemCount > 3 ? _scrollController : null;

    final listview = ListView.builder(
      controller: scrollController,
      itemCount: itemCount + 1, // +1은 count 표시
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return _buildCountListView(itemCount);
        }

        final LogenCode code = widget.data[index];

        // 앞에 붙이는 ff는 투명도
        final color = Color(int.parse(code.color, radix: 16)).withOpacity(1.0);

        return Ink(
          color: color.withAlpha(90),
          child: Card(
            margin: EdgeInsets.all(2),
            child: _buildListTile(code, color),
          ),
        );
      },
    );

    if (scrollController != null) {
      return DraggableScrollbar.arrows(
          controller: scrollController,
          backgroundColor: MyColors.backgroundColor,
          padding: EdgeInsets.all(5),
          child: listview);
    } else {
      return listview;
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final itemCount = widget.data?.length ?? 0;
    return _buildListView(itemCount);
  }
}
