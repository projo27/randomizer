import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/list_of_url_provider.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';

class ListOfUrlScreen extends StatelessWidget {
  const ListOfUrlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      tag: '/list_of_url',
      title: 'Random List Of URL',
      bottomBar: BottomBar(),
      child: Text("List of URL"),
    );
    return Text("List Of URL");
  }
}
