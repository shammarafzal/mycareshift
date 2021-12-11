import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Controllers/booking_controller.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class MyDayCardList extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Obx(() {
            return ListView.builder(
              itemCount: bookingController.bookingList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                // final DateFormat formatter = DateFormat('yyyy-MM-dd');
                // final String formatted = formatter.format(
                //     bookingController.bookingList[index].startDate);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: MyDay(
                      date: '${bookingController.bookingList[index].startDate}',
                      time:  bookingController.bookingList[index].time,
                      noOfPatients:  bookingController.bookingList[index].noOfCarers,
                      ammount: bookingController.bookingList[index].minHourlyRate,
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}

class MyDay extends StatefulWidget {
  final String date;
  final String time;
  final String noOfPatients;
  final String ammount;

  MyDay({
    required this.time,
    required this.noOfPatients,
    required this.date,
    required this.ammount,
  });

  @override
  _MyDayState createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text(
            widget.date,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: SizeConfig.screenWidth / 3,
                  child: Text(
                    'No of Carers',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
              Container(
                width: 1,
                height: double.maxFinite,
                color: Colors.grey,
              ),
              Container(
                  width: SizeConfig.screenWidth / 3,
                  child: Text(
                    'Amount',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
              Container(
                width: 1,
                height: double.maxFinite,
                color: Colors.grey,
              ),
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text(
                    'Time',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text(
                    widget.noOfPatients,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text(
                    widget.ammount,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text(
                    widget.time,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            title: 'View Details',
            onPress: () {
              Navigator.of(context).pushReplacementNamed('patients_list');
            },
          ),
        ),
      ],
    );
  }
}
