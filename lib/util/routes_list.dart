import 'package:flutter/cupertino.dart';
import 'package:randomizer/screen/country.dart';
import 'package:randomizer/screen/create_team.dart';
import 'package:randomizer/screen/date_between.dart';
import 'package:randomizer/screen/dice.dart';
import 'package:randomizer/screen/flip_coin.dart';
import 'package:randomizer/screen/google_sheet.dart';
import 'package:randomizer/screen/home.dart';
import 'package:randomizer/screen/list_of_text.dart';
import 'package:randomizer/screen/list_of_url.dart';
import 'package:randomizer/screen/music.dart';
import 'package:randomizer/screen/news.dart';
import 'package:randomizer/screen/number.dart';
import 'package:randomizer/screen/password_generator.dart';
import 'package:randomizer/screen/phone_contact.dart';
import 'package:randomizer/screen/photo_album.dart';
import 'package:randomizer/screen/rest_api.dart';

String get initialRoute => '/home';

Map<String, Widget Function(BuildContext)> get routeList => {
      '/home': (BuildContext context) => const HomeScreen(),
      '/number': (BuildContext context) => const NumberScreen(),
      '/list_of_text': (BuildContext context) => const ListOfTextScreen(),
      '/list_of_url': (BuildContext context) => const ListOfUrlScreen(),
      '/google_sheet': (BuildContext context) => const GoogleSheetScreen(),
      '/create_team': (BuildContext context) => const CreateTeamScreen(),
      '/dice': (BuildContext context) => const DiceScreen(),
      '/photo_album': (BuildContext context) => const PhotoAlbumScreen(),
      '/music': (BuildContext context) => const MusicScreen(),
      '/date': (BuildContext context) => const DateBetweenScreen(),
      '/country': (BuildContext context) => const CountryScreen(),
      '/flip_coin': (BuildContext context) => const FlipCoinScreen(),
      '/phone_contact': (BuildContext context) => const PhoneContactScreen(),
      '/password': (BuildContext context) => const PasswordGeneratorScreen(),
      '/news': (BuildContext context) => const NewsScreen(),
      '/rest_api': (BuildContext context) => const RestAPIScreen(),
    };
