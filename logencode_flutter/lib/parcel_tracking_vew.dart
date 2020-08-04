import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String datetimeToString(final DateTime date) {
  final f = DateFormat('yyyy-MM-dd HH:mm');
  return f.format(date);
}

/// API : https://tracker.delivery/guide/
/// 위 API의 로젠택배의 조회결과에서 배송상태 정보에 문제가 있어 해당 API의 출력결과를 그대로 사용할 수 는 없고
/// API의 리턴항목중 description값을 다시 파싱해서 제대로된 배송상태 값을 알 수 있음.
/// https://github.com/shlee322/delivery-tracker/blob/master/packages/apiserver/carriers/kr.logen/index.js
/// 위는 로젠택배조회 파싱소스로 참고할 것!
Future<TrackingInfo> fetchTrackingInfo(final String trackingNumber) async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return TrackingInfo.exception(
          '연결된 네트워크가 없습니다.\n모바일(3G/LTE/5G) 또는 와이파이 연결상태를 확인해주세요.');
    }

    final response = await http.get(
        'https://apis.tracker.delivery/carriers/kr.logen/tracks/${trackingNumber}');

    if (response.statusCode == 200) {
      return TrackingInfo.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      var reason = response.reasonPhrase;
      final body = json.decode(response.body);
      if (body != null) {
        final message = body['message'];
        if (message != null) reason = message;
      }
      return TrackingInfo.exception(reason);
    } else {
      return TrackingInfo.exception(
          '${response.statusCode}:${response.reasonPhrase}');
    }
  } catch (e) {
    return TrackingInfo.exception(e.toString());
  }
}

/// 발송/수령자 정보
class FromOrTo {
  /// 발송/수령인 이름
  final String name;

  /// 발송/수령 시각
  final DateTime time;

  FromOrTo(this.name, {this.time});

  factory FromOrTo.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final jsonTime = json['time'];
    var time = jsonTime != null ? DateTime.tryParse(jsonTime) : null;
    if (time != null) time = time.toLocal();
    return FromOrTo(name, time: time);
  }
}

class TrackingEvent {
  /// 시각
  final DateTime time;

  /// 위치
  final String location;

  /// 배송상태
  final String status;

  /// 배송내용
  final String description;

  /// 담당직원
  final String representative;

  /// 영업소
  final String branch;

  /// 연락처
  final String tel;

  /// 인수자
  final String consignee;

  TrackingEvent(this.time, this.status,
      {this.location,
      this.description,
      this.representative,
      this.tel,
      this.consignee,
      this.branch});

  factory TrackingEvent.fromJson(Map<String, dynamic> json) {
    var time = DateTime.tryParse(json['time']);

    //if (time != null) time = time.toLocal();
    final location = json['location']['name'];
    // 상태정보는 로젠택배 배송상태와 맞지 않아 사용안함.
    // final status = json['status'];

    final description = json['description'] as String;
    Map details = Map();

    if (description != null) {
      final items = description.split(',');

      for (var item in items) {
        var keyValue = item.split(':');
        if (keyValue?.length == 2) {
          details[keyValue[0].trim()] = keyValue[1].trim();
        }
      }
    }

    /// description 값 파싱처리
    /// https://github.com/shlee322/delivery-tracker/blob/master/packages/apiserver/carriers/kr.logen/index.js
    /// '발송점'이 '배송상태', '도작첨'이 '배송내용'이며
    /// '담당직원','영업소','인수자','연락처'는 정상임
    print(details.toString());
    return TrackingEvent(time, details['발송점'],
        location: location,
        description: details['도착점'],
        representative: details['담당직원'],
        tel: details['연락처'],
        consignee: details['인수자'],
        branch: details['영업소']);
  }
}

class TrackingInfo {
  /// 보내는 분
  final FromOrTo from;

  /// 받는 분
  final FromOrTo to;

  /// 배송상태
  final List<TrackingEvent> progresses;

  final String error;

  TrackingInfo(this.from, this.to, this.progresses, {this.error});

  factory TrackingInfo.fromJson(Map<String, dynamic> json) {
    final from = FromOrTo.fromJson(json['from']);
    final to = FromOrTo.fromJson(json['to']);
    final items = json['progresses'];

    List<TrackingEvent> progresses = List<TrackingEvent>();
    for (var item in items) {
      progresses.add(TrackingEvent.fromJson(item));
    }
    return TrackingInfo(from, to, progresses);
  }

  factory TrackingInfo.exception(String error) {
    return TrackingInfo(null, null, null, error: error);
  }
}

class ThinDivider extends Divider {
  ThinDivider(
      {Key key,
      double height = 1,
      double thickness = 1,
      double indent,
      double endIndent,
      Color color})
      : super(
            key: key,
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color);
}

class ParcelTrackingView extends StatefulWidget {
  /// 운송장번호
  final String trackingNumber;

  ParcelTrackingView(this.trackingNumber, {Key key}) : super(key: key);

  @override
  _ParcelTrackingViewState createState() => _ParcelTrackingViewState();
}

class _ParcelTrackingViewState extends State<ParcelTrackingView> {
  Future<TrackingInfo> _trackingInfo;

  @override
  void initState() {
    super.initState();
    _trackingInfo = fetchTrackingInfo(widget.trackingNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: FutureBuilder<TrackingInfo>(
            future: _trackingInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildTrackingInfo(snapshot.data);
              } else if (snapshot.hasError) {
                return ListView(
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  children: [
                    Center(child: Text('아래와 같은 오류로 인하여 현재 조회할 수 없습니다.')),
                    Divider(),
                    Center(
                        child: Text(snapshot.error == null
                            ? '오류내용을 알 수 없습니다.'
                            : snapshot.error)),
                    Divider(),
                    _buildOpenLogenHompageButton(),
                  ],
                );
              }

              // 조회중 리턴
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  /// 로젠택배에서 조회하기 버튼
  Widget _buildOpenLogenHompageButton() {
    return Card(
        color: Colors.amberAccent[100],
        child: FlatButton.icon(
            onPressed: () async {
              final url =
                  'https://www.ilogen.com/web/personal/trace/${widget.trackingNumber}';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            icon: Icon(Icons.open_in_browser),
            label: Text('로젠택배 홈페이지에서 조회')));
  }

  Widget _buildFromTo(TrackingInfo info) {
    ListTile createListTile(String label, String name) {
      return ListTile(
          trailing: Icon(Icons.person),
          title: _labelText(label, name),
          dense: true);
    }

    return Card(
        color: Colors.amberAccent[100],
        child: Column(children: [
          createListTile('보내는 분', info.from.name),
          ThinDivider(indent: 10, endIndent: 10),
          createListTile('받는 분', info.to.name)
        ]));
  }

  String _formattedTrackingNumber(String value) {
    return value.substring(0, 3) +
        '-' +
        value.substring(3, 7) +
        '-' +
        value.substring(7);
  }

  Widget _buildTrackingInfo(TrackingInfo info) {
    List<Widget> children = List<Widget>();

    if (info.error != null) {
      /// 정상적으로 응답은 받았으나 해당 송장번호의 조회결과가 없을 때
      children.add(Padding(padding: EdgeInsets.only(bottom: 20)));
      children.add(Center(child: Text(info.error)));
      children.add(Divider(
        height: 20,
      ));
    } else {
      children.add(Card(
          color: Colors.amberAccent[100],
          child: ListTile(
            title: _labelText(
                '송장번호', _formattedTrackingNumber(widget.trackingNumber),
                size: 20),
            dense: true,
          )));
      children.add(_buildFromTo(info));

      children.addAll(_buildProgresses(info.progresses));
    }

    children.add(_buildOpenLogenHompageButton());
    if (children.length > 0) {
      /// fab에 가려지는 현상을 막기 위해 빈공간 추가

      children.add(SizedBox(height: 100));
    }

    return ListView(
      padding: EdgeInsets.all(10),
      children: children,
    );
  }

  Widget _buildProgressCard(TrackingEvent event) {
    var description = event.description ?? '';
    if (event.representative != null) {
      description += '\n담당직원 : ${event.representative}';
    }

    if (event.consignee != null) {
      description += '\n인수자 : ${event.consignee}';
    }

    if (event.branch != null) {
      description += '\n영업소 : ${event.branch}';
      if (event.tel != null) {
        description += ' (연락처 : ${event.tel})';
      }
    }

    final seoulTime = event.time.toLocal();

    List<Widget> children = List<Widget>();

    children.add(ListTile(
      dense: true,
      title: _labelText(
        '${event.status}',
        '${datetimeToString(seoulTime)}',
        trailing: Text(
          event.location,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ),
    ));

    if (description.isNotEmpty) {
      children.add(ThinDivider(indent: 10, endIndent: 10));
      children.add(Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 15), child: Text(description))));
    }

    return Card(color: Colors.white, child: Column(children: children));
  }

  List<Widget> _buildProgresses(List<TrackingEvent> items) {
    List<Widget> list = List<Widget>();

    for (var item in items) {
      list.add(_buildProgressCard(item));
    }
    return list;
  }

  Widget _labelText(String label, String text,
      {double labelSize = 16,
      double labelWidth = 90,
      double size = 16,
      Widget trailing}) {
    final labelStyle =
        TextStyle(fontSize: labelSize, fontWeight: FontWeight.bold);
    final style = TextStyle(fontSize: size);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: labelWidth,
          child: Text(
            label,
            style: labelStyle,
          ),
        ),
        Expanded(
            child: Text(
          text,
          style: style,
        )),
        trailing != null ? trailing : SizedBox.shrink()
      ],
    );
  }
}
