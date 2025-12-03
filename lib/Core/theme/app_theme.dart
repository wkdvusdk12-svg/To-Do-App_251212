// 고정 색, 변화는 색 통합 / 라이트, 다트 모드 데이터

import 'package:flutter/material.dart';
import 'variable_colors.dart';
import 'fixed_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    // extensions = 만든 커스텀 색상, 앱 전체에서 사용 가능하게 함
    extensions: const [VariableColors.light, FixedColors.constant],
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    extensions: const [VariableColors.dark, FixedColors.constant],
  );
}
