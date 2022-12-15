import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/number_provider.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/randomized_animated_icon.dart';
import 'package:randomizer/widget/screen_container.dart';
import 'package:share_plus/share_plus.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen>
    with TickerProviderStateMixin {
  bool isParamShowed = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tabController.addListener(() {
        if (_tabController.indexIsChanging) {
          context.read<NumberProvider>().option = _tabController.index == 0
              ? NumberOption.range
              : NumberOption.list;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NumberProvider>();
    double paramHeight = MediaQuery.of(context).size.height / 2;
    // print("isloading: ${provider.executionState}");
    return ScreenContainer(
      tag: '/number',
      title: 'Number',
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
        onParamTap: () {
          setState(() {
            isParamShowed = !isParamShowed;
          });
        },
        onRandomize: () {
          setState(() {
            isParamShowed = false;
          });
          context.read<NumberProvider>().randomize();
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
                controller: _scrollController,
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
                        provider.theResult[index],
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
            duration: const Duration(milliseconds: 250),
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
                          controller: _tabController,
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
                                  Icon(Icons.numbers, size: 12),
                                  SizedBox(width: 4),
                                  Text('Range'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.format_list_numbered, size: 12),
                                  SizedBox(width: 4),
                                  Text('List'),
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
                          controller: _tabController,
                          children: [
                            _RangeNumberParam(),
                            _ListNumberParam(),
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

class _ListNumberParam extends StatefulWidget {
  const _ListNumberParam({Key? key}) : super(key: key);

  @override
  State<_ListNumberParam> createState() => _ListNumberParamState();
}

class _ListNumberParamState extends State<_ListNumberParam> {
  final _scrollController = ScrollController();
  final _listCtrl = TextEditingController();
  final TextEditingController resultAmountCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listCtrl.text = context.read<NumberProvider>().listOfNumberText;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NumberProvider>();
    resultAmountCtrl.text = provider.resultAmount.toString();

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Input Number List"),
                Text(
                  "*separate number with new line",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: TextFormField(
                controller: _listCtrl,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                      "(^(-?)(\\d+((\\.?\\d*)?))?(\\r\\n|\\n|\\r)?)",
                      multiLine: true,
                    ),
                    //ini regex untuk mendetek list of number /(^-?)(\d+((\.?\d*)?))/gm
                  )
                ],
                maxLines: null,
                keyboardType: TextInputType.multiline,
                toolbarOptions:
                    const ToolbarOptions(copy: true, selectAll: true),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.green, width: 2),
                  ),
                  border: const OutlineInputBorder(),
                  counterStyle: Theme.of(context).textTheme.caption,
                  counterText:
                      "length : ${provider.listOfNumber.join().length.toString()}, line : ${provider.listOfNumber.length}",
                ),
                onChanged: (val) {
                  var l = (const LineSplitter().convert(val)
                        ..removeWhere(
                            (element) => num.tryParse(element) == null))
                      .map((e) => num.parse(e))
                      .toList();
                  context.read<NumberProvider>().setListOfNumber(l);
                },
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
                      // if (val.isEmpty) val = "1";
                      // resultAmountCtrl.text = val;
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

class _RangeNumberParam extends StatelessWidget {
  _RangeNumberParam({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  final TextEditingController resultAmountCtrl = TextEditingController();
  final TextEditingController startRangeCtrl = TextEditingController();
  final TextEditingController endRangeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NumberProvider>();
    resultAmountCtrl.text = provider.resultAmount.toString();
    startRangeCtrl.text = provider.startRange.toString();
    endRangeCtrl.text = provider.endRange.toString();

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Start/Min Number"),
            const SizedBox(height: 8),
            TextFormField(
              controller: startRangeCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("^-?\\d*(.)?\\d*"))
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => provider.startRange = num.tryParse(val) ?? 0,
            ),
            const SizedBox(height: 12),
            const Text("End/Max Number"),
            const SizedBox(height: 8),
            TextFormField(
              controller: endRangeCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("^-?\\d*(.)?\\d*"))
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.green, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => provider.endRange = num.tryParse(val) ?? 0,
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
                      // if (val.isEmpty) val = "1";
                      // resultAmountCtrl.text = val;
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
