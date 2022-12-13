import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randomizer/util/colors.dart';

class AnimatedSmallBox extends StatefulWidget {
  const AnimatedSmallBox({
    Key? key,
    this.onAnimation = false,
    this.startColor = AppColor.white,
    this.endColor = AppColor.milk,
  }) : super(key: key);
  final bool onAnimation;
  final Color startColor;
  final Color endColor;

  @override
  State<AnimatedSmallBox> createState() => _AnimatedSmallBoxState();
}

class _AnimatedSmallBoxState extends State<AnimatedSmallBox>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: Random().nextInt(1000) + 100),
        vsync: this);

    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    animation = ColorTween(
      begin: widget.startColor,
      end: widget.endColor,
    ).animate(curve);

    if (!widget.onAnimation) {
      return;
    }

    animation.addStatusListener(_statusListener);
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedSmallBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onAnimation == widget.onAnimation) {
      return; // menghilangkan efek samping jika klik parameters
    }

    if (!widget.onAnimation) {
      animation.removeStatusListener(_statusListener);
      controller.reset();
      return;
    }
    animation.addStatusListener(_statusListener);
    controller.forward();
  }

  @override
  void dispose() {
    animation.removeStatusListener(_statusListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: animation.value,
            borderRadius: BorderRadius.circular(3),
          ),
          height: 12,
          width: 12,
        );
      },
    );
  }
}

class AnimatedRandomizeBox extends StatelessWidget {
  const AnimatedRandomizeBox({Key? key, required this.animate})
      : super(key: key);
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 42,
        width: 42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedSmallBox(onAnimation: animate),
                AnimatedSmallBox(
                  onAnimation: animate,
                  startColor: AppColor.milk,
                  endColor: AppColor.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedSmallBox(onAnimation: animate),
                AnimatedSmallBox(onAnimation: animate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
