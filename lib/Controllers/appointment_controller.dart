import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_appointment.dart';
import 'package:get/get.dart';


class AppointmentController extends GetxController{
  RxList<Appointment> appointmentList = <Appointment>[].obs;
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
      var appointment = await Utils().getAppointment();
      if(appointment != null){
        appointmentList.value = appointment;
      }
    } finally {
    }
  }

}