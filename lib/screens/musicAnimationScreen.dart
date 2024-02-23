import 'package:flutter/material.dart';

class MusicAnimationScreen extends StatefulWidget {
  const MusicAnimationScreen({super.key});

  @override
  State<MusicAnimationScreen> createState() => _MusicAnimationScreenState();
}

class _MusicAnimationScreenState extends State<MusicAnimationScreen>
    with TickerProviderStateMixin {
  //
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 750));

  late final Animation<double> _musicListMenuBottomPositionAnimation =
      Tween<double>(begin: -0.76, end: -0.05).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut));

  late final Animation<double> _musicPlayerTopPaddingAnimation =
      Tween<double>(begin: 0.25, end: 0.075).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut));

  late final Animation<double> _musicPlayerSizeAnimation =
      Tween<double>(begin: 0.8, end: 0.2).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut));

  late final Animation<double> _musicPlayerRightPaddingAnimation =
      Tween<double>(begin: _screenHorizontalPaddingPercentage, end: 0.7)
          .animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut));

  late final Animation<double> _songNameOpacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)));

  final double _musicListMenuHeightPercentage = 0.85;
  final double _screenHorizontalPaddingPercentage = 0.075;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.secondary.withOpacity(0.25),
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Positioned(
                  top: MediaQuery.of(context).size.height *
                      _musicPlayerTopPaddingAnimation.value,
                  left: MediaQuery.of(context).size.width *
                      _screenHorizontalPaddingPercentage,
                  right: MediaQuery.of(context).size.width *
                      _musicPlayerRightPaddingAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background),
                    width: MediaQuery.of(context).size.width *
                        _musicPlayerSizeAnimation.value,
                    height: MediaQuery.of(context).size.width *
                        _musicPlayerSizeAnimation.value,
                  ),
                );
              }),
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Positioned(
                  bottom: MediaQuery.of(context).size.height *
                      _musicListMenuBottomPositionAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *
                        _musicListMenuHeightPercentage,
                    child: LayoutBuilder(builder: (context, boxConstraints) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_animationController.isCompleted) {
                                _animationController.reverse();
                              } else {
                                _animationController.forward();
                              }
                            },
                            onVerticalDragEnd: (details) {
                              if (_animationController.value >= 0.45) {
                                _animationController.forward();
                              } else {
                                _animationController.reverse();
                              }
                            },
                            onVerticalDragUpdate:
                                (DragUpdateDetails dragUpdateDetails) {
                              final dragged =
                                  (dragUpdateDetails.primaryDelta ?? 0.0) /
                                      MediaQuery.of(context).size.height;

                              _animationController.value =
                                  _animationController.value - (dragged * 1.75);
                            },
                            child: Container(
                              width: boxConstraints.maxWidth,
                              height: boxConstraints.maxHeight * (0.11),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25))),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                );
              }),
          Positioned(
              top: MediaQuery.of(context).size.height *
                  _screenHorizontalPaddingPercentage,
              left: MediaQuery.of(context).size.width * (0.325),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * (0.6),
                height: MediaQuery.of(context).size.width * (0.2),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _songNameOpacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Now Playing",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                          ),
                          Text(
                            "Dil se mat khel\nK.K. (Pal)",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
