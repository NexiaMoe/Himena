// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nexiamoe_eighteen/service/api_service.dart';
import 'package:video_viewer/video_viewer.dart';
import 'dart:io' show Platform;

class InfoDetail extends StatefulWidget {
  const InfoDetail({Key? key, required this.id, required this.cover})
      : super(key: key);
  final int id;
  final String cover;

  @override
  _InfoDetail createState() => _InfoDetail();
}

class _InfoDetail extends State<InfoDetail> {
  final VideoViewerController controller = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return FutureBuilder(
          future: GetInfo.getDetail(widget.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Scaffold(
                body: Center(child: Text("Loading Detail...")),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.name),
                ),
                body: Column(children: [
                  VideoViewer(
                    controller: controller,
                    style: VideoViewerStyle(
                        thumbnail: Image.network(snapshot.data.cover),
                        volumeBarStyle:
                            VolumeBarStyle(bar: BarStyle.volume(height: 0))),
                    enableVerticalSwapingGesture: false,
                    source: {
                      if (snapshot.data.low != null)
                        "360p": VideoSource(
                          video:
                              VideoPlayerController.network(snapshot.data.low),
                        ),
                      if (snapshot.data.med != null)
                        "480p": VideoSource(
                            video: VideoPlayerController.network(
                                snapshot.data.med)),
                      if (snapshot.data.high != null)
                        "720p": VideoSource(
                            video: VideoPlayerController.network(
                                snapshot.data.high)),
                      if (snapshot.data.fhd != null)
                        "1080p": VideoSource(
                            video: VideoPlayerController.network(
                                snapshot.data.fhd)),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          SizedBox(
                            child: Image.network(widget.cover),
                            height: 200,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Text(snapshot.data.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24)),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Text(snapshot.data.description
                                    .toString()
                                    .replaceAll("\\n", "")
                                    .replaceAll("\\n\\n", "\n"))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            }
          });
    } else {
      return FutureBuilder(
          future: GetInfo.getDetail(widget.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading Detail..."),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.name),
                ),
                body:
                    Row(children: const [Flexible(child: Text('Coming Soon'))]),
              );
            }
          });
    }
  }

  String? getactiveSourceNameName() => controller.activeSourceName;
  String? getActiveCaption() => controller.activeCaption;
  bool isFullScreen() => controller.isFullScreen;
  bool isBuffering() => controller.isBuffering;
  bool isPlaying() => controller.isPlaying;
}
