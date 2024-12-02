import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:randomizer/provider/abstract_provider.dart';

enum DateTimeOption { date, time }

class DateFormatOption {
  String format;
  String example;
  DateFormatOption(this.format, this.example);
}

List<DateFormatOption> dateFormatOptionList = [
  DateFormatOption('dd/MM/yyyy', '31/08/2022'),
  DateFormatOption('MM/dd/yyyy', '08/31/2022'),
  DateFormatOption('dd.MM.yyyy', '31.08.2022'),
  DateFormatOption('d MMM yyyy', '31 Aug 2022'),
  DateFormatOption("EEE, MMM d, yyyy", 'Wed, Aug 31, 2022'),
];

class DateProvider extends AbstractProvider {
  DateTimeOption _option = DateTimeOption.date;

  List<String> theResult = [];
  List<int> theResultTempList = [];
  int resultAmount = 1;
  bool _withTime = false;
  bool _distinct = false;
  bool _sort = true;
  bool _isAsc = true;
  String _dateFormat = dateFormatOptionList[0].format;

  String get dateTimeFormat => "$_dateFormat${_withTime ? ' HH:mm' : ''}";
  set dateTimeFormat(String dateFormat) {
    _dateFormat = dateFormat;
    notifyListeners();
  }

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
    theResult.clear();
    duration = 0;
    try {
      if (startDate.compareTo(endDate) > 0) {
        var end = startDate;
        startDate = endDate;
        endDate = end;
      }

      if (_withTime) {
        if (distinct) {
          await dateTimeDistinctProcessor();
        } else {
          await dateTimeProcessor();
        }
      } else {
        listOfDateTemp.clear();
        theResultTempList.clear();

        for (DateTime i = startDate;
            i.compareTo(endDate) < 0;
            i = i.add(const Duration(days: 1))) {
          listOfDateTemp.add(i);
        }

        if (distinct) {
          await dateDistinctProcessor();
        } else {
          await dateProcessor();
        }
      }

      if (_sort) {
        // DateFormat(dateTimeFormat).parseStrict();

        theResult.sort((a, b) => isAsc
            ? DateFormat(dateTimeFormat)
                .parse(a)
                .compareTo(DateFormat(dateTimeFormat).parse(b))
            : DateFormat(dateTimeFormat)
                .parse(b)
                .compareTo(DateFormat(dateTimeFormat).parse(a)));
        // l.sort((a, b) => isAsc ? a.compareTo(b) : b.compareTo(a));
      }
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
    try {
      if (duration > 10000) return;
      if (listOfDateTemp.length < resultAmount) {
        resultAmount = listOfDateTemp.length;
      }

      for (int i = 0; i < resultAmount; i++) {
        await delay(resultAmount: resultAmount);

        int r = Random().nextInt(listOfDateTemp.length);
        theResult.add(DateFormat(dateTimeFormat).format(listOfDateTemp[r]!));
      }
    } catch (e) {
      print(e);
    } finally {
      return;
    }
  }

  dateDistinctProcessor() async {
    if (listOfDateTemp.length < resultAmount) {
      resultAmount = listOfDateTemp.length;
    }

    listOfDateTemp.shuffle();

    for (int i = 0; i < resultAmount; i++) {
      await delay(resultAmount: resultAmount);
      theResult.add(DateFormat(dateTimeFormat).format(listOfDateTemp[i]!));
    }
    return;
  }

  dateTimeProcessor() async {
    listOfDateTemp.clear();
    int start = startDate.millisecondsSinceEpoch;
    int end = endDate.millisecondsSinceEpoch;

    //print("$start $end");

    // 60000 = 60 second * 1000 milisecond
    for (int i = start; i <= end; i += 60000) {
      listOfDateTemp.add(DateTime.fromMillisecondsSinceEpoch(i));
    }

    if (listOfDateTemp.length < resultAmount) {
      resultAmount = listOfDateTemp.length;
    }

    for (int l = 0; l < resultAmount; l++) {
      await delay(resultAmount: resultAmount);
      int r = Random().nextInt(listOfDateTemp.length);
      theResult.add(DateFormat(dateTimeFormat).format(listOfDateTemp[r]!));
    }
  }

  dateTimeDistinctProcessor() async {
    listOfDateTemp.clear();
    int start = startDate.millisecondsSinceEpoch;
    int end = endDate.millisecondsSinceEpoch;
    // 60000 = 60 second * 1000 milisecond
    for (int i = start; i <= end; i += 60000) {
      listOfDateTemp.add(DateTime.fromMillisecondsSinceEpoch(i));
    }

    if (listOfDateTemp.length < resultAmount) {
      resultAmount = listOfDateTemp.length;
    }

    listOfDateTemp.shuffle();

    for (int l = 0; l < resultAmount; l++) {
      await delay(resultAmount: resultAmount);
      theResult.add(DateFormat(dateTimeFormat).format(listOfDateTemp[l]!));
    }
  }
}
