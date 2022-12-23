import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomizer/provider/abstract_provider.dart';

enum DateTimeOption { date, time }

class DateProvider extends AbstractProvider {
  DateTimeOption _option = DateTimeOption.date;

  List<String> theResult = [];
  List<int> theResultTempList = [];
  int resultAmount = 1;
  bool _withTime = false;
  bool _distinct = false;
  bool _sort = true;
  bool _isAsc = true;
  // DateTime startDate = DateTime.now().subtract(const Duration(days: 365));
  DateTime startDate =
      DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 365)));
  DateTime endDate =
      DateUtils.dateOnly(DateTime.now().add(const Duration(days: 365)));

  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 23, minute: 59);

  List<DateTime> listOfDate = [];
  List<DateTime?> listOfDateTemp = [];
  List<num?> listOfTimeTemp = [];

  DateTimeOption get option => _option;
  set option(DateTimeOption option) {
    _option = option;
    notifyListeners();
  }

  bool get withTime => _withTime;
  set withTime(bool withTime) {
    _withTime = withTime;
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

  setStartDate(DateTime? date) {
    startDate = date ?? startDate;
    notifyListeners();
  }

  setEndDate(DateTime? date) {
    endDate = date ?? endDate;
    notifyListeners();
  }

  setStartTime(TimeOfDay time) {
    startTime = time;
    notifyListeners();
  }

  setEndTime(TimeOfDay time) {
    // print("${timeToNum(time)} ${timeToNum(startTime)}");
    if (timeToNum(time) < timeToNum(startTime)) {
      endTime = startTime;
      startTime = time;
    } else {
      endTime = time;
    }
    notifyListeners();
  }

  int timeToNum(TimeOfDay time) {
    return (time.hour * 60) + time.minute;
  }

  TimeOfDay numToTime(int num) {
    return TimeOfDay(
        hour: (num / 60).floor(), minute: num - (num / 60).floor() * 60);
  }

  String timeToString(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void randomize() async {
    theResult.clear();
    if (option == DateTimeOption.date) {
      await randomizeDate();
      return;
    } else {
      randomizeTime();
      return;
    }
  }

  randomizeDate() async {
    setLoading();
    try {
      await delay();
      theResult = ["Gundul", "Pacul"];
      setSuccess();
    } catch (e) {
      setError();
    }
  }

  randomizeTime() async {
    setLoading();
    theResult.clear();
    duration = 0;
    try {
      listOfTimeTemp.clear();
      theResultTempList.clear();

      for (num i = timeToNum(startTime); i <= timeToNum(endTime); i++) {
        listOfTimeTemp.add(i);
      }
      await timeProcessor();

      if (_sort) {
        theResult.sort((a, b) => isAsc ? a.compareTo(b) : b.compareTo(a));
      }

      setSuccess();
    } catch (e) {
      setError();
    }
  }

  timeProcessor() async {
    if (theResult.length == resultAmount) return;
    if (distinct && theResult.length == listOfTimeTemp.length) {
      resultAmount = listOfTimeTemp.length;
      return;
    }

    await delay();
    var m = Map.from(List.from(listOfTimeTemp).asMap());

    if (distinct) {
      for (int i = 0; i < theResultTempList.length; i++) {
        m.removeWhere((key, value) => key == theResultTempList[i]);
      }
    }

    int r = Random().nextInt((m.length));

    if (distinct && theResultTempList.contains(m.keys.elementAt(r))) {
      return await timeProcessor();
    } else {
      theResultTempList.add(m.keys.elementAt(r));
      theResult.add(timeToString(numToTime(m.values.elementAt(r))));
    }
    return await timeProcessor();
  }

  dateProcessor() async {
    var diff = endDate.difference(startDate);

    if (theResult.length == resultAmount) return;
    if (distinct && theResult.length == diff.inDays + 1) {
      resultAmount = theResult.length;
      return;
    }

    if (distinct) {}
  }

  dateTimeProcessor() async {}
}
