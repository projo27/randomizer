import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomizer/screen/random_menu.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/util/image_map.dart';
import 'package:randomizer/widget/background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          const BackgroundWidget(),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 80),
            child: RandomMenuScreen(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColor.green.withOpacity(0.5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 42,
                    width: 42,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: AppColor.white,
                        padding: EdgeInsets.all(2),
                      ),
                      child: SvgPicture.asset(svgMap["more"]!),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.all(2),
                      ),
                      child: SvgPicture.asset(svgMap["randomize"]!),
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    width: 42,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: AppColor.white,
                        padding: EdgeInsets.all(2),
                      ),
                      child: SvgPicture.asset(svgMap["param"]!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
