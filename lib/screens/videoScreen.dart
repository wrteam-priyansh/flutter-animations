import 'dart:collection';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  late bool _initializedVideo = false;
  late final YoutubeExplode _youtubeExplode = YoutubeExplode();

  @override
  void initState() {
    initYoutubeVideo();
    super.initState();
  }

  void initYoutubeVideo() async {
    final muxed = (await _youtubeExplode.videos.streamsClient
            .getManifest("https://www.youtube.com/watch?v=Dpp1sIL1m5Q"))
        .muxed;
    SplayTreeMap resolutionsMuxed = SplayTreeMap.fromIterable(
      muxed,
      key: (item) => item.qualityLabel,
      value: (item) => item.url.toString(),
    );

    Map<String, String> resolutions = {};

    String url = resolutionsMuxed[resolutionsMuxed.lastKey()];
    for (var key in resolutionsMuxed.keys) {
      String processedKey = key.split(" ")[0];
      resolutions[processedKey] = resolutionsMuxed[key];
    }

    _betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, url,
        resolutions: resolutions);

    //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'

    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            autoPlay: true,
            deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]));
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);

    _initializedVideo = true;
    setState(() {});
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    _youtubeExplode.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _initializedVideo
          ? BetterPlayer(controller: _betterPlayerController)
          : const SizedBox(),
    );
  }
}
