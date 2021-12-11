import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_rewards.dart';
import 'package:get/get.dart';


class RewardController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Rewards> rewardList = <Rewards>[].obs;
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
    fetchRewards();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchRewards());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchRewards() async{
    try {
      // isLoading(true);
      var rewards = await Utils().getRewards();
      if(rewards != null){
        rewardList.value = rewards;
      }
    } finally {
      // isLoading(false);
    }
  }

}