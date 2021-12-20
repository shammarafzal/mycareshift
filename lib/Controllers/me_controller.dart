import 'dart:async';
import 'dart:io';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_me.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeController extends GetxController{
  RxList<Me> meList = <Me>[].obs;
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
      final SharedPreferences prefs =
      await SharedPreferences.getInstance();
      var me = await Utils().getMe();
      if(me != null){
        meList.value = me;
        prefs.setString('isApproved',
            meList[0].isApproved);
      }
    } on SocketException catch (e) {
      timer?.cancel();
      await EasyLoading.showError('No Internet');
    }finally {

    }
  }

}