import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/list_of_text.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';

class ListOfTextScreen extends StatelessWidget {
  const ListOfTextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      tag: '/list_of_text',
      title: 'Random List Of Text',
      bottomBar: BottomBar(),
      child: Text("List of Text"),
    );
  }
}
