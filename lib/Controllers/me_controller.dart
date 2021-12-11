import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_me.dart';
import 'package:get/get.dart';


class MeController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Me> meList = <Me>[].obs;
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
    fetchMe();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchMe());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchMe() async{
    try {
      // isLoading(true);
      var me = await Utils().getMe();
      if(me != null){
        meList.value = me;
      }
    } finally {
      // isLoading(false);
    }
  }

}