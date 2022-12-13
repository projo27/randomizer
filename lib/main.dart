import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/util/provider_list.dart';
import 'package:randomizer/util/routes_list.dart';
import 'package:randomizer/util/theme_data.dart';
import 'package:randomizer/widget/scroll_behavior.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        title: 'Randomizer',
        theme: themeData,
        routes: routeList,
        initialRoute: initialRoute,
        scrollBehavior: AppScrollBehavior(),
      ),
    );
  }
}
