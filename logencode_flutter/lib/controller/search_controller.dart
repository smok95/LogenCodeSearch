import 'package:logencode_flutter/model/logen_code.dart';

import '../util.dart';

class SearchController {
  var _source = List<LogenCode>();

  Future<void> initialize() async {
    _source = await LogenCode.getList();
  }

  List<LogenCode> get data => _source;

  /// 검색
  List<LogenCode> search(String keyword) {
    // 문자열에서 자음/모음 제거
    keyword = Util.removeLastHangulJamo(keyword);
    final result = List<LogenCode>.from(_source);

    for (var word in keyword.split(" ")) {
      if (word.isEmpty) continue;
      result.removeWhere((element) => !element.contains(word));
    }
    return result;
  }
}
