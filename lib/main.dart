import 'package:flutter/material.dart';
import 'package:randomizer/util/routes_list.dart';
import 'package:randomizer/util/theme_data.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer',
      theme: themeData,
      routes: routeList,
      initialRoute: initialRoute,
    );
  }
}
