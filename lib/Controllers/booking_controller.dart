import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_booking.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{

  RxList<Booking> bookingList = <Booking>[].obs;
  Timer? timer;

  @override
  void onInit() {
    fetchBooking();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchBooking());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchBooking() async{
    try {
      var booking = await Utils().getBooking();
      if(booking != null){
        bookingList.value = booking;
      }
    } finally {
    }
  }

}