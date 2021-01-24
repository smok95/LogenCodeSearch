class Util {
  /// 문자열 끝에 자음/모음 제거
  static String removeLastHangulJamo(String text) {
    if (text?.isEmpty ?? true) return '';

    final lastIndex = text.length - 1;
    final c = text.codeUnitAt(lastIndex);
    // 문자값이 자음 또는 모음인 경우에는 제외처리
    if (c >= 0x3130 && c <= 0x318f) {
      return text.substring(0, lastIndex);
    }
    return text;
  }
}
