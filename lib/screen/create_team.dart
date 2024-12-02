import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/create_team_provider.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/randomized_animated_icon.dart';
import 'package:randomizer/widget/screen_container.dart';
import 'package:share_plus/share_plus.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({Key? key}) : super(key: key);

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  bool isParamShowed = false;
  final ScrollController _scrollCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<CreateTeamProvider>();
    double paramHeight = MediaQuery.of(context).size.height;

    return ScreenContainer(
      tag: '/create_team',
      title: 'Create Team for play',
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
          // context.read<CreateTeamProvider>().randomize();
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
                        child: const Text(" gundul pacul"),
                      ),
                      const SizedBox(height: 8),
                      // Expanded(
                      //   flex: 1,
                      //   child: TabBarView(
                      //     controller: _tabCtrl,
                      //     children: [
                      //       _DateParam(),
                      //       _TimeParam(),
                      //     ],
                      //   ),
                      // )
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
