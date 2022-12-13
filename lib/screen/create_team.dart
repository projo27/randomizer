import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/create_team_provider.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      tag: '/create_team',
      title: 'Create Team for play',
      bottomBar: BottomBar(
          // provider: context.read<CreateTeamProvider>(),
          ),
      child: Text("Create Your Team"),
    );
  }
}
