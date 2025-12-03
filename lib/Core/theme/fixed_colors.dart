// 라이트, 다크 모드 상관 없이 고정된 색상들


import 'package:flutter/material.dart';


@immutable
class FixedColors extends ThemeExtension<FixedColors> {
  const FixedColors({required this.brandColor});
  final Color? brandColor;

  static const FixedColors constant = FixedColors(
    brandColor: Color(0xFFD58E3B), 
  );

  @override
  FixedColors copyWith({Color? brandColor}) =>
      FixedColors(brandColor: brandColor ?? this.brandColor);

  // lerp() = 라이트/다크 교체 시 자연스러운 전환
  @override
  FixedColors lerp(ThemeExtension<FixedColors>? other, double t) {
    if (other is! FixedColors) return this;
    return FixedColors(brandColor: Color.lerp(brandColor, other.brandColor, t));
  }
}

FixedColors fxc(BuildContext context) =>
    Theme.of(context).extension<FixedColors>()!;
