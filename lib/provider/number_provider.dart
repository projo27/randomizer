import 'dart:math';

import 'package:randomizer/provider/abstract_provider.dart';

enum NumberOption { range, list }

class NumberProvider extends AbstractProvider {
  NumberProvider();

  NumberOption _option = NumberOption.range;
  int resultAmount = 1;
  bool _distinct = false;
  bool _sort = true;
  bool _isAsc = true;

  int duration = 0;

  num startRange = 0;
  num endRange = 100;
  List<num> listOfNumber = [];
  List<num?> listOfNumberTemp = [];

  List<String> theResult = [];
  List<int> theResultTempList = [];

  NumberOption get option => _option;
  set option(NumberOption option) {
    _option = option;
    notifyListeners();
  }

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

  setListOfNumber(List<num> list) {
    listOfNumber = list;
    notifyListeners();
  }

  get listOfNumberText => listOfNumber.join("\n");
  get distinctListOfNumber => [
        ...{...listOfNumber}
      ];

  randomizeRange() async {
    setLoading();
    theResult.clear();
    duration = 0;
    try {
      await rangeProcessor();
      if (_sort) {
        theResult.sort((a, b) => isAsc
            ? double.parse(a).compareTo(double.parse(b))
            : double.parse(b).compareTo(double.parse(a)));
      }
      setSuccess();
    } catch (e) {
      setError();
    }
  }

  randomizeList() async {
    setLoading();
    theResult.clear();
    theResultTempList.clear();
    duration = 0;
    try {
      await listProcessor();
      if (_sort) {
        theResult.sort((a, b) => isAsc
            ? double.parse(a).compareTo(double.parse(b))
            : double.parse(b).compareTo(double.parse(a)));
      }
      setSuccess();
    } catch (e) {
      setError();
    }
  }

  randomize() {
    if (_option == NumberOption.range) {
      randomizeRange();
      return;
    }
    randomizeList();
  }

  int getNumberOfDecimals(String number) {
    if (number.contains('.')) {
      if (number.split(".")[1] == "0") return 0;
      return number.split(".")[1].length;
    }
    return 0;
  }

  int get numberOfDecimal {
    return getNumberOfDecimals(startRange.toString()) <
            getNumberOfDecimals(endRange.toString())
        ? getNumberOfDecimals(endRange.toString())
        : getNumberOfDecimals(startRange.toString());
  }

  rangeProcessor() async {
    if (theResult.length == resultAmount) return;
    if (distinct && theResult.length == (endRange - startRange + 1)) {
      resultAmount = ((endRange - startRange + 1).round());
      return;
    }

    int time = (Random().nextInt(100) + 100).round();
    duration += time;

    await Future.delayed(Duration(milliseconds: time));
    double r = (Random().nextDouble() * (startRange + endRange)) + startRange;
    if (distinct && theResult.contains(r.toStringAsFixed(numberOfDecimal))) {
      return await rangeProcessor();
    } else {
      theResult.add(r.toStringAsFixed(numberOfDecimal));
    }
    return await rangeProcessor();
  }

  listProcessor() async {
    if (theResult.length == resultAmount) return;

    if (distinct && theResult.length == distinctListOfNumber.length) {
      resultAmount = distinctListOfNumber.length;
      return;
    }

    int time = (Random().nextInt(100) + 100).round();
    duration += time;

    await Future.delayed(Duration(milliseconds: time));

    var m = Map.from(
        List.from(distinct ? distinctListOfNumber : listOfNumber).asMap());

    if (distinct) {
      for (int i = 0; i < theResultTempList.length; i++) {
        m.removeWhere((key, value) => key == theResultTempList[i]);
      }
    }

    int r = Random().nextInt((m.length));
    print(
        "$m length : ${m.length} random : $r nilai : ${m[r]} temp : $theResultTempList");
    if (distinct && theResultTempList.contains(m.keys.elementAt(r))) {
      return await listProcessor();
    } else {
      theResultTempList.add(m.keys.elementAt(r));
      theResult.add(m.values.elementAt(r).toString());
    }
    return await listProcessor();
  }
}
