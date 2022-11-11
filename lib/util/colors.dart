import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class AppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color milk = Color(0xFFE8D3A3);
  static const Color orange = Color(0xFFFFA633);
  static const Color blue = Color(0xFF3B5A9D);
  static const Color green = Color(0xFF4FB2AA);
  static const Color black50 = Color(0xFF59597C);
  static const Color black = Color(0xFF3D3D41);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: AppColor.white,
  error: Color(0xFFD76565),
  onBackground: AppColor.black50,
  onError: AppColor.white,
  primary: AppColor.orange,
  onPrimary: AppColor.black,
  secondary: AppColor.milk,
  onSecondary: AppColor.blue,
  surface: AppColor.green,
  onSurface: AppColor.milk,
);
