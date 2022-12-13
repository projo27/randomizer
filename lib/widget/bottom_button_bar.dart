import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/util/image_map.dart';
import 'package:randomizer/widget/randomized_animated_icon.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    this.onParameterChanged,
    this.onRandomize,
    this.onParamTap,
    this.isLoading = false,
    this.isParamOpen = false,
  }) : super(key: key);
  final ValueChanged<dynamic>? onParameterChanged;
  final VoidCallback? onRandomize;
  final VoidCallback? onParamTap;
  final bool isLoading;
  final bool isParamOpen;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isParamOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BottomBar oldWidget) {
    if (isParamOpen != widget.isParamOpen) {
      setState(() {
        isParamOpen = widget.isParamOpen;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(0.7),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 42,
            width: 42,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: AppColor.white,
                padding: const EdgeInsets.all(2),
              ),
              child: SvgPicture.asset(svgMap["more"]!),
            ),
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onRandomize,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: const EdgeInsets.all(2),
              ),
              child: AnimatedRandomizeBox(animate: widget.isLoading),
            ),
          ),
          SizedBox(
            height: 42,
            width: 42,
            child: ElevatedButton(
              onPressed: widget.onParamTap != null
                  ? () {
                      setState(() => isParamOpen = !isParamOpen);
                      widget.onParamTap!();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: isParamOpen ? AppColor.milk : AppColor.white,
                padding: const EdgeInsets.all(2),
              ),
              child: isParamOpen
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.black50,
                    )
                  : SvgPicture.asset(
                      svgMap["param"]!,
                      color: AppColor.black,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
