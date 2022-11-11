import 'package:flutter/cupertino.dart';
import 'package:randomizer/screen/home.dart';
import 'package:randomizer/screen/number.dart';

String get initialRoute => '/home';

Map<String, Widget Function(BuildContext)> get routeList => {
      "/home": (BuildContext context) => const HomeScreen(),
      "/number": (BuildContext context) => const NumberScreen(),
    };
