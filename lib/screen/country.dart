import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/provider/number_provider.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/widget/bottom_button_bar.dart';
import 'package:randomizer/widget/screen_container.dart';
import 'package:share_plus/share_plus.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen>
    with TickerProviderStateMixin {
  bool isParamShowed = false;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NumberProvider>();
    return ScreenContainer(
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
      tag: '/country',
      title: "Country",
      child: Stack(
        children: [
          Positioned(
            bottom: 30,
            right: 24,
            child: Text(
              "data : ${provider.resultAmount}, duration : ${provider.duration} ms",
              style: Theme.of(context).textTheme.bodySmall,
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
    );
  }
}
