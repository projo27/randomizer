import 'dart:math';

import 'package:randomizer/provider/abstract_provider.dart';

class ListOfTextProvider extends AbstractProvider {
  int resultAmount = 1;

  List<String> theResult = [];
  List<int> theResultTempList = [];
  List<String> listOfText = [];

  bool _distinct = false;
  bool _sort = true;
  bool _isAsc = true;
  bool _isTrim = true;

  bool get isTrim => _isTrim;
  set isTrim(bool isTrim) {
    _isTrim = isTrim;
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

  setListOfText(List<String> list) {
    listOfText = list.map((e) => _isTrim ? e.trim() : e).toList();
    notifyListeners();
  }

  get listOfTextString => listOfText.join("\n");
  get distinctListOfText => [
        ...{...listOfText}
      ];

  randomize() {
    randomizeList();
  }

  randomizeList() async {
    setLoading();
    theResult.clear();
    theResultTempList.clear();
    duration = 0;
    try {
      await listProcessor();
      if (_sort) {
        theResult.sort((a, b) => isAsc ? a.compareTo(b) : b.compareTo(a));
      }
      setSuccess();
    } catch (e) {
      setError();
    }
  }

  listProcessor() async {
    if (theResult.length == resultAmount) return;

    if (distinct && theResult.length == distinctListOfText.length) {
      resultAmount = distinctListOfText.length;
      return;
    }
    await delay();

    var m =
        Map.from(List.from(distinct ? distinctListOfText : listOfText).asMap());

    if (distinct) {
      for (int i = 0; i < theResultTempList.length; i++) {
        m.removeWhere((key, value) => key == theResultTempList[i]);
      }
    }

    int r = Random().nextInt((m.length));
    // print(
    //     "$m length : ${m.length} random : $r nilai : ${m[r]} temp : $theResultTempList");
    if (distinct && theResultTempList.contains(m.keys.elementAt(r))) {
      return await listProcessor();
    } else {
      theResultTempList.add(m.keys.elementAt(r));
      theResult.add(m.values.elementAt(r).toString());
    }
    return await listProcessor();
  }
}
