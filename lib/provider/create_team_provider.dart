import 'package:randomizer/provider/abstract_provider.dart';

class Team {
  String name;
  int level;
  int? teamNumber;

  Team(this.name, this.level, {this.teamNumber});
}

class CreateTeamProvider extends AbstractProvider {
  List<String> theResult = [];
  List<String> listOfTemp = [];

  int resultAmount = 1;
  bool _distinct = false;
  bool _sort = true;
  bool _isAsc = true;

  bool get distinct => _distinct;
  set distinct(bool distinct) {
    _distinct = distinct;
    notifyListeners();
  }

  bool get order => _sort;
  set order(bool order) {
    _sort = order;
    notifyListeners();
  }

  bool get isAsc => _isAsc;
  set isAsc(bool isAsc) {
    _isAsc = isAsc;
    notifyListeners();
  }

  setResultAmount(int amount) {
    resultAmount = (amount < 1) ? 1 : amount;
    notifyListeners();
  }

  increaseResultAmount() {
    resultAmount++;
    notifyListeners();
  }

  decreaseResultAmount() {
    if (resultAmount == 1) return;
    resultAmount--;
    notifyListeners();
  }
}
