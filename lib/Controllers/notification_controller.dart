import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_notifications.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Notification> notificationList = <Notification>[].obs;
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
    fetchNotifications();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchNotifications());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchNotifications() async{
    try {
      // isLoading(true);
      var notifications = await Utils().getNotifications();
      if(notifications != null){
        notificationList.value = notifications;
      }
    } finally {
      // isLoading(false);
    }
  }

}