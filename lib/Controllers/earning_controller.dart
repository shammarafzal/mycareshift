import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_earning.dart';
import 'package:get/get.dart';


class EarningController extends GetxController{
  RxList<Earning> earningList = <Earning>[].obs;
  Timer? timer;

  @override
  void onInit() {
    fetchEarning();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchEarning());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchEarning() async{
    try {
      var earning = await Utils().getEarning();
      if(earning != null){
        earningList.value = earning;
      }
    } finally {
    }
  }

}