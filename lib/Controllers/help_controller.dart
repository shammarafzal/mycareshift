import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_help.dart';
import 'package:get/get.dart';


class HelpController extends GetxController{
  RxList<Help> helpList = <Help>[].obs;
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

      var help = await Utils().getHelp();
      if(help != null){
        helpList.value = help;
      }
    } finally {

    }
  }

}