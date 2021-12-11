import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_appointment.dart';
import 'package:becaring/Models/get_help.dart';
import 'package:get/get.dart';


class AppointmentController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Appointment> appointmentList = <Appointment>[].obs;
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
    fetchAppointment();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchAppointment());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchAppointment() async{
    try {
      // isLoading(true);
      var appointment = await Utils().getAppointment();
      if(appointment != null){
        appointmentList.value = appointment;
      }
    } finally {
      // isLoading(false);
    }
  }

}