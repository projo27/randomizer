import 'package:flutter/material.dart';
import 'package:randomizer/util/colors.dart';
import 'package:randomizer/util/random_menu_list.dart';

class RandomMenuScreen extends StatelessWidget {
  const RandomMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // padding: const EdgeInsets.only(bottom: 70),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.86,
          ),
          itemCount: randomMenuImages.length,
          itemBuilder: (context, index) {
            return MenuItem(menuImage: randomMenuImages[index]);
            // return Text(randomMenuImages[index].description);
          },
          padding: const EdgeInsets.only(bottom: 24),
        ),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  const MenuItem({Key? key, required this.menuImage}) : super(key: key);
  final MenuImage menuImage;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool showDescription = false;

  @override
  Widget build(BuildContext context) {
    // return Hero(
    //   tag: widget.menuImage.routeName,
    // child:
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(widget.menuImage.routeName);
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child:
                  Image.asset(widget.menuImage.imageAsset, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Visibility(
              visible: widget.menuImage.proOnly || widget.menuImage.onDevelop,
              child: Chip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: widget.menuImage.proOnly,
                      child: const Tooltip(
                        message: "For Pro Only, (Everybody need Money :D)",
                        child: Icon(
                          Icons.verified_user,
                          size: 16,
                          color: AppColor.orange,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.menuImage.proOnly &&
                          widget.menuImage.onDevelop,
                      child: const SizedBox(width: 8),
                    ),
                    Visibility(
                      visible: widget.menuImage.onDevelop,
                      child: const Tooltip(
                        message: "Under Development Mode, wait for it",
                        child: Icon(
                          Icons.work,
                          size: 16,
                          color: AppColor.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.green.withOpacity(0.85),
              ),
              height: 50,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showDescription = !showDescription;
                  });
                },
                child: Center(
                  child: Text(
                    widget.menuImage.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            top: showDescription ? 0 : 300,
            bottom: 0,
            left: 0,
            right: 0,
            curve: Curves.easeIn,
            child: InkWell(
              onTap: () {
                setState(() {
                  showDescription = !showDescription;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: AppColor.green,
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.menuImage.title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // const Divider(color: AppColor.white, thickness: 0.2),
                    const SizedBox(height: 16),
                    Text(
                      widget.menuImage.description,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AppColor.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        //   ),
      ),
    );
  }
}
