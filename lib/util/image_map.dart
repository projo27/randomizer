import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Map<String, String> svgMap = {
  "more": "assets/icons/more_circle.svg",
  "param": "assets/icons/params.svg",
  "randomize": "assets/icons/randomize.svg",
};

Widget svgImage(String assetName, {Color? color}) {
  try {
    return SvgPicture.asset(assetName, color: color);
  } catch (e) {
    return Icon(Icons.image_not_supported, color: color);
  }
}
