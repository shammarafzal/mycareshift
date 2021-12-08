import 'package:becaring/API/utils.dart';
import 'package:becaring/Controllers/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'chew.dart';

class VideosViewer extends StatefulWidget {
  @override
  _VideosViewerState createState() => _VideosViewerState();
}

class _VideosViewerState extends State<VideosViewer> {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: Container(child: Obx(() {
        return ListView.builder(
          itemCount: videoController.videoList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return Card(
                elevation: 5,
                child: ChewieListItem(
                  videoPlayerController: VideoPlayerController.network(
                    Utils().image_base_url +
                        '${videoController.videoList[index].media}',
                  ),
                  looping: false,
                ));
          },
        );
      })),
    );
  }
}
