import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:randomizer/provider/date_provider.dart';
import 'package:randomizer/provider/list_of_text_provider.dart';
import 'package:randomizer/provider/number_provider.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<NumberProvider>(create: (context) => NumberProvider()),
  ChangeNotifierProvider<ListOfTextProvider>(
    create: (context) => ListOfTextProvider(),
  ),
  ChangeNotifierProvider<DateProvider>(
    create: (context) => DateProvider(),
  ),
];
