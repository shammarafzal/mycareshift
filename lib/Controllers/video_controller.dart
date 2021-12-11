import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:get/get.dart';


class VideoController extends GetxController{
  RxList<TrainingVideo> videoList = <TrainingVideo>[].obs;
  Timer? timer;

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchVideos());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchVideos() async{
    try {
      var videos = await Utils().getVideos();
      if(videos != null){
        videoList.value = videos;
      }
    } finally {

    }
  }

}