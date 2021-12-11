import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_notifications.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController{
  RxList<Notification> notificationList = <Notification>[].obs;
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
      var notifications = await Utils().getNotifications();
      if(notifications != null){
        notificationList.value = notifications;
      }
    } finally {

    }
  }

}