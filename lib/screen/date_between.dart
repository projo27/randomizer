// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/date_provider.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/util/theme_data.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/randomized_animated_icon.dart';
import 'package:randomizer/widget/screen_container.dart';
import 'package:share_plus/share_plus.dart';

class DateBetweenScreen extends StatefulWidget {
  const DateBetweenScreen({Key? key}) : super(key: key);

  @override
  State<DateBetweenScreen> createState() => _DateBetweenScreenState();
}

class _DateBetweenScreenState extends State<DateBetweenScreen>
    with TickerProviderStateMixin {
  bool isParamShowed = false;
  late TabController _tabCtrl;
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tabCtrl.addListener(() {
        if (_tabCtrl.indexIsChanging) {
          context.read<DateProvider>().option =
              _tabCtrl.index == 0 ? DateTimeOption.date : DateTimeOption.time;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DateProvider>();
    double paramHeight = MediaQuery.of(context).size.height / 2;
    return ScreenContainer(
      tag: '/date',
      title: 'Dates and Time',
      appbarAction: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await Clipboard.setData(
              ClipboardData(
                text:
                    "${provider.theResult.join("\n")}\n\nGenerated with Randomizer APK",
              ),
            );
          },
          icon: const Icon(Icons.copy),
          iconSize: 16,
          // color: AppColor.milk,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await Share.share(
                "${provider.theResult.join("\n")}\n\nGenerated with Randomizer APK");
          },
          icon: const Icon(Icons.share_outlined),
          iconSize: 16,
          // color: AppColor.milk,
        ),
        const SizedBox(width: 12),
      ],
      bottomBar: BottomBar(
        onRandomize: () {
          setState(() {
            isParamShowed = false;
          });
          context.read<DateProvider>().randomize();
        },
        onParamTap: () {
          setState(() {
            isParamShowed = !isParamShowed;
          });
        },
        isLoading: provider.isLoading,
        isParamOpen: isParamShowed,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(24).copyWith(top: 32, bottom: 48),
            // height: double.infinity,
            width: double.infinity,
            child: Visibility(
              visible: !provider.isLoading,
              replacement: Transform.scale(
                scale: 3,
                child: AnimatedRandomizeBox(
                  animate: provider.isLoading,
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                // controller: _scrollController,
                itemCount: provider.theResult.length,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: const [0.01, 0.01],
                        colors: [
                          AppColor.black50,
                          AppColor.white.withOpacity(0.5)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      dense: true,
                      // horizontalTitleGap: 24,
                      title: Text(
                        provider.theResult[index].toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColor.black,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 24,
            child: Text(
              "data : ${provider.resultAmount}, duration : ${provider.duration} ms",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          AnimatedPositioned(
            bottom: isParamShowed ? 0 : paramHeight * -1 + 20,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 150),
            curve: isParamShowed ? Curves.easeOut : Curves.easeIn,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  height: paramHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(4),
                        height: 36,
                        child: TabBar(
                          controller: _tabCtrl,
                          labelColor: AppColor.white,
                          indicator: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          unselectedLabelColor: AppColor.black50,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.date_range, size: 12),
                                  SizedBox(width: 4),
                                  Text('Date'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.timer_sharp, size: 12),
                                  SizedBox(width: 4),
                                  Text('Time'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                          controller: _tabCtrl,
                          children: [
                            _DateParam(),
                            _TimeParam(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: isParamShowed,
                  child: Positioned(
                    right: -8,
                    top: -8,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isParamShowed = !isParamShowed;
                        });
                      },
                      color: AppColor.black50,
                      icon: const Icon(
                        Icons.cancel,
                        // color: AppColor.black50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeParam extends StatefulWidget {
  const _TimeParam({Key? key}) : super(key: key);

  @override
  State<_TimeParam> createState() => __TimeParamState();
}

class __TimeParamState extends State<_TimeParam> {
  final _scrollCtrl = ScrollController();
  final TextEditingController resultAmountCtrl = TextEditingController();
  final TextEditingController startTimeCtrl = TextEditingController();
  final TextEditingController endTimeCtrl = TextEditingController();

  _showTimePicker(BuildContext context, {bool isStartTime = true}) async {
    var initialTime = isStartTime
        ? context.read<DateProvider>().startTime
        : context.read<DateProvider>().endTime;
    var time = await showTimePicker(context: context, initialTime: initialTime);

    if (isStartTime) {
      context
          .read<DateProvider>()
          .setStartTime(time ?? const TimeOfDay(hour: 0, minute: 0));
    } else {
      context
          .read<DateProvider>()
          .setEndTime(time ?? const TimeOfDay(hour: 0, minute: 0));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DateProvider>();
    resultAmountCtrl.text = provider.resultAmount.toString();
    startTimeCtrl.text = provider.startTime.format(context);
    endTimeCtrl.text = provider.endTime.format(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        controller: _scrollCtrl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Start Time"),
            const SizedBox(height: 8),
            TextFormField(
              controller: startTimeCtrl,
              readOnly: true,
              onTap: () {
                _showTimePicker(context, isStartTime: true);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text("End Time"),
            const SizedBox(height: 8),
            TextFormField(
              controller: endTimeCtrl,
              readOnly: true,
              onTap: () {
                _showTimePicker(context, isStartTime: false);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Result Amount :"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    provider.decreaseResultAmount();
                  },
                  icon: const Icon(
                    Icons.do_not_disturb_on_outlined,
                    color: AppColor.green,
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: resultAmountCtrl,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        provider.resultAmount = int.parse(val);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    provider.increaseResultAmount();
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Distinct Result"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.distinct,
                  onChanged: (val) => provider.distinct = val ?? false,
                ),
                const Text("Yes"),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Sort the Result :"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.order,
                  onChanged: (val) => provider.order = val ?? false,
                ),
                const Text("Yes"),
                const SizedBox(width: 50),
                const Text("ASC"),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    thumbColor: AppColor.green,
                    trackColor: Colors.grey[200],
                    activeColor: Colors.grey[200],
                    value: !provider.isAsc,
                    onChanged: (val) => provider.isAsc = !val,
                  ),
                ),
                const Text("DESC"),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _DateParam extends StatefulWidget {
  const _DateParam({Key? key}) : super(key: key);

  @override
  State<_DateParam> createState() => __DateParamState();
}

class __DateParamState extends State<_DateParam> {
  final _scrollCtrl = ScrollController();
  final TextEditingController resultAmountCtrl = TextEditingController();
  final TextEditingController startDateCtrl = TextEditingController();
  final TextEditingController endDateCtrl = TextEditingController();

  _showTimePicker(BuildContext context, {bool isStartTime = true}) async {
    var initialTime = isStartTime
        ? TimeOfDay.fromDateTime(context.read<DateProvider>().startDate)
        : TimeOfDay.fromDateTime(context.read<DateProvider>().endDate);
    var time = await showTimePicker(context: context, initialTime: initialTime);

    if (time == null) return;

    if (isStartTime) {
      context.read<DateProvider>().setStartDate(
            DateUtils.dateOnly(context.read<DateProvider>().startDate).add(
              Duration(
                hours: time.hour,
                minutes: time.minute,
              ),
            ),
          );
    } else {
      context.read<DateProvider>().setEndDate(
            DateUtils.dateOnly(context.read<DateProvider>().endDate).add(
              Duration(
                hours: time.hour,
                minutes: time.minute,
              ),
            ),
          );
    }
  }

  _showDatePicker(
    BuildContext context, {
    bool isStartDate = true,
    bool withTime = false,
  }) async {
    var initialDate = isStartDate
        ? context.read<DateProvider>().startDate
        : context.read<DateProvider>().endDate;
    var date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2999),
      builder: (context, child) {
        return Theme(
          data: themeData.copyWith(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              background: AppColor.green,
              error: Color(0xFFD76565),
              onBackground: AppColor.black50,
              onError: AppColor.white,
              primary: AppColor.green,
              onPrimary: AppColor.white,
              secondary: AppColor.black,
              onSecondary: AppColor.blue,
              surface: AppColor.green,
              onSurface: AppColor.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;

    if (withTime) {
      _showTimePicker(context, isStartTime: isStartDate);
    }

    if (isStartDate) {
      context.read<DateProvider>().setStartDate(date);
    } else {
      context.read<DateProvider>().setEndDate(date);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DateProvider>();
    var dateFormat =
        provider.withTime ? DateFormat.yMd().add_Hm() : DateFormat.yMd();
    resultAmountCtrl.text = provider.resultAmount.toString();
    startDateCtrl.text = dateFormat.format(provider.startDate);
    endDateCtrl.text = dateFormat.format(provider.endDate);

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        controller: _scrollCtrl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Date With Time"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.withTime,
                  onChanged: (val) => provider.withTime = val ?? false,
                ),
                const Text("Yes"),
              ],
            ),
            const SizedBox(height: 12),
            Text("Start Date ${provider.withTime ? 'Time' : ''}"),
            const SizedBox(height: 8),
            TextFormField(
              controller: startDateCtrl,
              readOnly: true,
              onTap: () {
                _showDatePicker(context,
                    isStartDate: true, withTime: provider.withTime);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Text("End Date ${provider.withTime ? 'Time' : ''}"),
            const SizedBox(height: 8),
            TextFormField(
              controller: endDateCtrl,
              readOnly: true,
              onTap: () {
                _showDatePicker(context,
                    isStartDate: false, withTime: provider.withTime);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Result Amount :"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    provider.decreaseResultAmount();
                  },
                  icon: const Icon(
                    Icons.do_not_disturb_on_outlined,
                    color: AppColor.green,
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: resultAmountCtrl,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        provider.resultAmount = int.parse(val);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    provider.increaseResultAmount();
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Distinct Result"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.distinct,
                  onChanged: (val) => provider.distinct = val ?? false,
                ),
                const Text("Yes"),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Sort the Result :"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.order,
                  onChanged: (val) => provider.order = val ?? false,
                ),
                const Text("Yes"),
                const SizedBox(width: 50),
                const Text("ASC"),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    thumbColor: AppColor.green,
                    trackColor: Colors.grey[200],
                    activeColor: Colors.grey[200],
                    value: !provider.isAsc,
                    onChanged: (val) => provider.isAsc = !val,
                  ),
                ),
                const Text("DESC"),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
