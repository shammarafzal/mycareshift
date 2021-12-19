import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Controllers/booking_details.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PatientsCardList extends StatelessWidget {
  final arguments = Get.arguments as Map;

  @override
  Widget build(BuildContext context) {
    BookingDetailsController bookingDetailsController = Get.put(
        BookingDetailsController(appointment_id: arguments['appointment_id']));
    return Scaffold(
      appBar: AppBar(
        title: Text('My Patients'),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
          color: Colors.white,
          child: Obx(() {
            return ListView.builder(
              itemCount: bookingDetailsController.bookingDetailstList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: PatientsView(
                      name: bookingDetailsController.bookingDetailstList[0].patient.user.name,
                      address: bookingDetailsController.bookingDetailstList[0].patient.user.address,
                      phone: bookingDetailsController.bookingDetailstList[0].patient.user.phone,
                      disease: bookingDetailsController.bookingDetailstList[0].patient.bloodGroup,
                      date: bookingDetailsController.bookingDetailstList[0].startDate,
                      time: bookingDetailsController.bookingDetailstList[0].time,
                      lat: bookingDetailsController.bookingDetailstList[0].patient.user.addressLatitude,
                      lng: bookingDetailsController.bookingDetailstList[0].patient.user.addressLongitude,
                      appointment_id: bookingDetailsController.bookingDetailstList[0].id.toString(),
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}

class PatientsView extends StatefulWidget {
  final String name;
  final String address;
  final String phone;
  final String disease;
  final String date;
  final String time;
  final String lat;
  final String lng;
  final String appointment_id;

  PatientsView({
    required this.name,
    required this.address,
    required this.phone,
    required this.disease,
    required this.date,
    required this.time,
    required this.lat,
    required this.lng,
    required this.appointment_id,
  });

  @override
  _PatientsViewState createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      indicatorStyle: IndicatorStyle(
          color: Colors.blueAccent,
          width: 20,
          indicatorXY: 0,
          padding: EdgeInsets.all(1)),
      endChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person_pin_sharp,
                color: Colors.blueAccent,
              ),
              title: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.maps_home_work_rounded,
                color: Colors.blueAccent,
              ),
              title: Expanded(
                child: Text(
                  widget.address,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.blueAccent,
              ),
              title: Text(
                widget.phone,
                style: TextStyle(),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.coronavirus,
                color: Colors.blueAccent,
              ),
              title: Text(
                widget.disease,
                style: TextStyle(),
              ),
            ),
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      width: SizeConfig.screenWidth / 3,
                      child: CustomButton(
                        title: 'Start Navigation',
                        onPress: () {
                          print(widget.appointment_id);
                          Navigator.of(context)
                              .pushReplacementNamed('/navigation', arguments: {'lat': widget.lat, 'lng': widget.lng, 'appointment_id': widget.appointment_id});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      startChild: Container(
        child: Text(
          widget.time,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
