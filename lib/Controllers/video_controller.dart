import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:get/get.dart';


class VideoController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<TrainingVideo> videoList = <TrainingVideo>[].obs;
  // @override
  // void onInit(){
  //   fetchCategories();
  //   super.onInit();
  //
  //
  // }
  //
  // @override
  // void onClose(){
  //   super.onClose();
  // }
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
      // isLoading(true);
      var videos = await Utils().getVideos();
      if(videos != null){
        videoList.value = videos;
      }
    } finally {
      // isLoading(false);
    }
  }

}