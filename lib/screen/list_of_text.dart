import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/list_of_text_provider.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/randomized_animated_icon.dart';
import 'package:randomizer/widget/screen_container.dart';
import 'package:share_plus/share_plus.dart';

class ListOfTextScreen extends StatefulWidget {
  const ListOfTextScreen({Key? key}) : super(key: key);

  @override
  State<ListOfTextScreen> createState() => _ListOfTextScreenState();
}

class _ListOfTextScreenState extends State<ListOfTextScreen>
    with TickerProviderStateMixin {
  bool isParamShowed = false;

  // late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _tabController.addListener(() {
      //   if (_tabController.indexIsChanging) {
      //     context.read<Listoftextpro>().option = _tabController.index == 0
      //         ? NumberOption.range
      //         : NumberOption.list;
      //   }
      // });
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ListOfTextProvider>();
    double paramHeight = MediaQuery.of(context).size.height / 2;

    return ScreenContainer(
      tag: '/list_of_text',
      title: 'Random List Of Text',
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
          context.read<ListOfTextProvider>().randomize();
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
            duration: const Duration(milliseconds: 150),
            curve: isParamShowed ? Curves.easeOut : Curves.easeIn,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8).copyWith(top: 24),
                  margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  height: paramHeight,
                  child: _ListTextParam(),
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

class _ListTextParam extends StatefulWidget {
  const _ListTextParam({Key? key}) : super(key: key);

  @override
  State<_ListTextParam> createState() => _ListTextParamState();
}

class _ListTextParamState extends State<_ListTextParam> {
  final _scrollController = ScrollController();
  final _listCtrl = TextEditingController();
  final TextEditingController resultAmountCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listCtrl.text = context.read<ListOfTextProvider>().listOfTextString;
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
    var provider = context.watch<ListOfTextProvider>();
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
                Text("Input Text List"),
                Text(
                  "*separate text with new line",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: TextFormField(
                controller: _listCtrl,
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(
                //     RegExp(
                //       "(^(-?)(\\d+((\\.?\\d*)?))?(\\r\\n|\\n|\\r)?)",
                //       multiLine: true,
                //     ),
                //     //ini regex untuk mendetek list of number /(^-?)(\d+((\.?\d*)?))/gm
                //   )
                // ],
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
                      "length : ${provider.listOfText.join().length.toString()}, line : ${provider.listOfText.length}",
                ),
                onChanged: (val) {
                  var l = (const LineSplitter().convert(val)
                        ..removeWhere((element) => element.isEmpty))
                      .toList();
                  context.read<ListOfTextProvider>().setListOfText(l);
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text("Trim Text"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: provider.isTrim,
                  onChanged: (val) => provider.isTrim = val ?? false,
                ),
                const Text("Yes"),
              ],
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
