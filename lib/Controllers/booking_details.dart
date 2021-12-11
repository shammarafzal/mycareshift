import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Models/get_bookings_details.dart';
import 'package:get/get.dart';

class BookingDetailsController extends GetxController{
  final String appointment_id;
  BookingDetailsController({
    required this.appointment_id,
  });

  RxList<BookingDetails> bookingDetailstList = <BookingDetails>[].obs;
  Timer? timer;

  @override
  void onInit() {
    fetchBookingDetails();
    super.onInit();
    timer = Timer.periodic(Duration(seconds: 8), (Timer t) => fetchBookingDetails());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchBookingDetails() async{
    try {
      var bookingDetails = await Utils().getBookingDetails(appointment_id);
      if(bookingDetails != null){
        bookingDetailstList.value = bookingDetails;
      }
    } finally {

    }
  }

}