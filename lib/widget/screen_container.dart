import 'package:flutter/material.dart';
import 'package:randomizer/widget/background.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer(
      {Key? key,
      required this.tag,
      required this.child,
      this.bottomBar,
      required this.title,
      this.appbarAction})
      : super(key: key);
  final String tag;
  final String title;
  final Widget child;
  final Widget? bottomBar;
  final List<Widget>? appbarAction;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(title),
          centerTitle: true,
          actions: appbarAction,
        ),
        body: Stack(
          children: [
            const BackgroundWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60,
                horizontal: 20,
              ).copyWith(bottom: 80),
              child: child,
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomBar),
          ],
          // child: Text("Ini Number"),
        ),
      ),
    );
  }
}
