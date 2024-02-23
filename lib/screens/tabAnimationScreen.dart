import 'package:flutter/material.dart';

const String photosKey = "Photos";
const String videosKey = "Videos";

class TabAnimationScreen extends StatefulWidget {
  const TabAnimationScreen({super.key});

  @override
  State<TabAnimationScreen> createState() => _TabAnimationScreenState();
}

class _TabAnimationScreenState extends State<TabAnimationScreen> {
  String selectedTabTitleKey = photosKey;

  Duration tabChangeAnimationDuration = const Duration(milliseconds: 400);

  Widget _buildTabBarContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20)),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Stack(
          children: [
            AnimatedAlign(
              duration: tabChangeAnimationDuration,
              curve: Curves.easeInOut,
              alignment: selectedTabTitleKey == photosKey
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: Container(
                margin: const EdgeInsetsDirectional.all(10),
                width: boxConstraints.maxWidth * (0.5),
                height: boxConstraints.maxHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).scaffoldBackgroundColor),
                alignment: Alignment.center,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabTitleKey = photosKey;
                  });
                },
                child: Container(
                  width: boxConstraints.maxWidth * (0.5),
                  height: boxConstraints.maxHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  alignment: Alignment.center,
                  child: const Text(
                    photosKey,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabTitleKey = videosKey;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: boxConstraints.maxWidth * (0.5),
                  height: boxConstraints.maxHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: const Text(
                    videosKey,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [Center(child: _buildTabBarContainer())],
        ),
      ),
    );
  }
}
