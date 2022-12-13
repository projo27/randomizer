import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:randomizer/provider/number_provider.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<NumberProvider>(
    create: (context) => NumberProvider(),
  ),
];
