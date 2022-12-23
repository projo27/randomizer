import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomizer/util/colors.dart';

ThemeData get themeData {
  final base = ThemeData.light();
  const colorSheme = lightColorScheme;

  return base.copyWith(
    colorScheme: colorSheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      headline6: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.bold, fontSize: 18),
      bodyText1: GoogleFonts.plusJakartaSans(color: colorSheme.onSurface),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(AppColor.green),
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.white),
      ),
    ),

    timePickerTheme: TimePickerThemeData(
      dialTextColor: AppColor.white,
      entryModeIconColor: AppColor.white,
      hourMinuteTextColor: AppColor.white,
      helpTextStyle: base.textTheme.overline!.copyWith(color: AppColor.white),
    ),

    /// Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      // checkColor: MaterialStateProperty.all<Color>(AppColor.green),
      fillColor: MaterialStateProperty.all<Color>(AppColor.green),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(AppColor.milk),
      thumbColor: MaterialStateProperty.all<Color>(AppColor.green),
    ),

    hintColor: AppColor.green,
    // inputDecorationTheme: InputDecorationTheme(
    //   bor
    // )
  );
}
