import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/dice_provider.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';

class DiceScreen extends StatelessWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      tag: '/dice',
      title: 'Roll the Dice',
      bottomBar: BottomBar(),
      child: Text("Flip Coin"),
    );
    // return Text("Dice");
  }
}
