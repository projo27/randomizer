import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:randomizer/util/colors.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          right: -(height / 8),
          top: 0,
          child: Container(
            width: height / 3,
            height: height / 3,
            decoration: const BoxDecoration(
              color: AppColor.milk,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -(height / 6),
          bottom: -30,
          child: Container(
            width: height / 2,
            height: height / 2,
            decoration: BoxDecoration(
              color: AppColor.orange.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -90,
          top: 50,
          child: Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              color: AppColor.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -120,
          bottom: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: AppColor.green.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 100.0,
            sigmaY: 100.0,
          ),
          // blendMode: BlendMode.color,
          child: Container(),
        ),
      ],
    );
  }
}
