import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_help.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:get/get.dart';


class HelpController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Help> helpList = <Help>[].obs;
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
    fetchHelp();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchHelp());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchHelp() async{
    try {
      // isLoading(true);
      var help = await Utils().getHelp();
      if(help != null){
        helpList.value = help;
      }
    } finally {
      // isLoading(false);
    }
  }

}