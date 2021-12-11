import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_booking.dart';
import 'package:get/get.dart';


class BookingController extends GetxController{
  // var isLoading = true.obs;
  // var categoryList = <Category>[].obs;
  RxList<Booking> bookingList = <Booking>[].obs;
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
      // isLoading(true);
      var booking = await Utils().getBooking();
      if(booking != null){
        bookingList.value = booking;
      }
    } finally {
      // isLoading(false);
    }
  }

}