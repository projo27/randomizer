import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/flip_coin_provider.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';

class FlipCoinScreen extends StatelessWidget {
  const FlipCoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      tag: '/flip_coin',
      title: 'Flip Coin',
      bottomBar: BottomBar(
        onRandomize: () {},
      ),
      child: Center(child: Text("Flip Coin")),
    );
  }
}
