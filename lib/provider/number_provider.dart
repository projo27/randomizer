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

  String get listOfNumberText => listOfNumber.join("\n");
  List<num> get distinctListOfNumber => [
        ...{...listOfNumber}
      ];

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

  randomize() {
    if (_option == NumberOption.range) {
      randomizeRange();
      return;
    }
    randomizeList();
  }

  randomizeRange() async {
    setLoading();
    theResult.clear();
    duration = 0;
    try {
      if (int.tryParse(startRange.toString()) != null &&
          int.tryParse(endRange.toString()) != null) {
        await rangeProcessorInt();
      } else {
        await rangeDoubleProcessor();
      }
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

  rangeIntProcessor() async {
    listOfNumberTemp.clear();

    for (int i = startRange.round(); i < endRange.round() + 1; i++) {
      listOfNumberTemp.add(i);
    }

    if (listOfNumberTemp.length < resultAmount) {
      resultAmount = listOfNumberTemp.length;
    }

    listOfNumberTemp.shuffle();

    for (int i = 0; i < resultAmount; i++) {
      int r = Random().nextInt(listOfNumberTemp.length);
      await delay(resultAmount: resultAmount);
      theResult.add(listOfNumberTemp[r].toString());
    }
  }

  rangeIntDistinctProcessor() async {
    listOfNumberTemp.clear();

    for (int i = startRange.round(); i < endRange.round() + 1; i++) {
      listOfNumberTemp.add(i);
    }

    if (listOfNumberTemp.length < resultAmount) {
      resultAmount = listOfNumberTemp.length;
    }

    listOfNumberTemp.shuffle();
    for (int i = 0; i < resultAmount; i++) {
      await delay(resultAmount: resultAmount);
      theResult.add(listOfNumberTemp[i].toString());
    }
  }

  rangeDoubleProcessor() async {
    if (theResult.length == resultAmount) return;
    if (distinct && theResult.length == (endRange - startRange + 1)) {
      resultAmount = ((endRange - startRange + 1).round());
      return;
    }

    await delay();

    double r = (Random().nextDouble() * (startRange + endRange)) + startRange;
    if (distinct && theResult.contains(r.toStringAsFixed(numberOfDecimal))) {
      return await rangeDoubleProcessor();
    } else {
      theResult.add(r.toStringAsFixed(numberOfDecimal));
    }
    return await rangeDoubleProcessor();
  }

  rangeProcessorInt() async {
    if (distinct) {
      await rangeIntDistinctProcessor();
    } else {
      await rangeIntProcessor();
    }
  }

  randomizeList() async {
    setLoading();
    theResult.clear();
    theResultTempList.clear();
    duration = 0;
    try {
      if (distinct) {
        await distinctListProcessor();
      } else {
        await listProcessor();
      }
      if (_sort) {
        theResult.sort((a, b) => isAsc
            ? num.parse(a).compareTo(num.parse(b))
            : num.parse(b).compareTo(num.parse(a)));
      }
      setSuccess();
    } catch (e) {
      setError();
    }
  }

  listProcessor() async {
    if (listOfNumber.length < resultAmount) {
      resultAmount = listOfNumber.length;
    }

    listOfNumber.shuffle();
    for (int i = 0; i < resultAmount; i++) {
      await delay(resultAmount: resultAmount);
      theResult.add(listOfNumber[i].toString());
    }
  }

  distinctListProcessor() async {
    if (distinctListOfNumber.length < resultAmount) {
      resultAmount = distinctListOfNumber.length;
    }

    distinctListOfNumber.shuffle();
    for (int i = 0; i < resultAmount; i++) {
      await delay(resultAmount: resultAmount);
      theResult.add(distinctListOfNumber[i].toString());
    }
  }
}
