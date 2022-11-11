import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomizer/util/colors.dart';

ThemeData get themeData {
  final base = ThemeData.light();
  const colorSheme = lightColorScheme;

  return base.copyWith(
    // backgroundColor: colorSheme.surface,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      bodyText1: GoogleFonts.plusJakartaSans(color: colorSheme.onSurface),
    ),
  );
}
