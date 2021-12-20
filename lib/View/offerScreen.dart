import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Controllers/appointment_controller.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferCardList extends StatelessWidget {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Obx(() {
            return ListView.builder(
              itemCount: appointmentController.appointmentList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Offers(
                    time: '${appointmentController.appointmentList[index].startDate}',
                    hours: appointmentController.appointmentList[index].visitDuration,
                    ammount: '\£${appointmentController.appointmentList[index].minHourlyRate}',
                    address: appointmentController.appointmentList[index].patient.user.address,
                    tip: appointmentController.appointmentList[index].time,
                    patient_id: appointmentController.appointmentList[index].patientId,
                  ),
                );
              },
            );
          })),
    );
  }
}

class Offers extends StatefulWidget {
  final String time;
  final String hours;
  final String address;
  final String ammount;
  final String tip;
  final String patient_id;
  Offers({
    required this.time,
    required this.hours,
    required this.address,
    required this.ammount,
    required this.tip,
    required this.patient_id
  });

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.time,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(widget.hours),
          trailing: Text(
            widget.ammount,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(widget.address),
          trailing: Text(widget.tip),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            title: 'Accept offer',
            onPress: () async {
              try {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                var isApproved = prefs.getString('isApproved');
                var responseApprove = await Utils().checkApprove();
                if (responseApprove['nurse']['image'] == " " && responseApprove['nurse_detail']['identification_document'] == null && responseApprove['nurse_detail']['dbs_certificate'] == null && responseApprove['nurse_detail']['care_qualification_certificate'] == null) {
                  Navigator.of(context).pushReplacementNamed(
                      '/custom_doc_complete');
                }
                // else if(responseApprove['nurse']['is_approved'] != "Approved"){
                //   _timer?.cancel();
                //   await EasyLoading.showSuccess(
                //       response['message']);
                // }
                else {
                  await EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  var response =
                  await Utils().bookAppointment(widget.patient_id);
                  if (response['status'] == true) {
                    _timer?.cancel();
                    await EasyLoading.showSuccess(
                        response['message']);
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                  else {
                    _timer?.cancel();
                    await EasyLoading.showError(
                        response['message']);
                  }
                }
              }
              catch(e){
                _timer?.cancel();
                await EasyLoading.showError(e.toString());
              }
            },
          ),
        ),
      ],
    );
  }
}
