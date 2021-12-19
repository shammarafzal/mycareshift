import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Controllers/booking_details.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/View/patientMedications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PatientDetailsCardList extends StatelessWidget {
  final arguments = Get.arguments as Map;

  @override
  Widget build(BuildContext context) {
    BookingDetailsController bookingDetailsController =
        Get.put(BookingDetailsController(appointment_id: arguments['appointment_id']));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Patient Info'),
        ),
        body: Container(
            color: Colors.white,
            child: Obx(() {
              return ListView.builder(
                itemCount: bookingDetailsController.bookingDetailstList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return PatientInfo(
                      name: bookingDetailsController.bookingDetailstList[0].patient.user.name,
                      address: bookingDetailsController.bookingDetailstList[0].patient.user.address,
                      // img: '',
                      dob: bookingDetailsController.bookingDetailstList[0].patient.dob,
                      blood: bookingDetailsController.bookingDetailstList[0].patient.bloodGroup,
                      pheight: bookingDetailsController.bookingDetailstList[0].patient.height,
                      pweight: bookingDetailsController.bookingDetailstList[0].patient.weight,
                      pdisease: bookingDetailsController.bookingDetailstList[0].patient.allergies,
                      appoint_id: '${bookingDetailsController.bookingDetailstList[0].id}',
                      visit_duration: '${bookingDetailsController.bookingDetailstList[0].visitDuration}'

                  );
                },
              );
            })));
  }
}

class PatientInfo extends StatefulWidget {
  final String name;
  final String address;
  // final String img;
  final String dob;
  final String blood;
  final String pheight;
  final String pweight;
  final String pdisease;
  final String appoint_id;
  final String visit_duration;

  PatientInfo({
    required this.name,
    required this.address,
    // required this.img,
    required this.dob,
    required this.blood,
    required this.pheight,
    required this.pweight,
    required this.pdisease,
    required this.appoint_id,
    required this.visit_duration,
  });

  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  Timer? _timer;
  int _start = 120;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: ListTile(
                title: Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.address,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   image: DecorationImage(
                //       image: NetworkImage(widget.img), fit: BoxFit.fill),
                // ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 185,
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/128/2693/2693507.png'), fit: BoxFit.fill),
                  ),
                ),
                title: Text(
                  widget.dob,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Date of Birth',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              width: 150,
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/128/1477/1477227.png'), fit: BoxFit.fill),
                  ),
                ),
                title: Text(
                  widget.blood,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Blood',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 185,
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3209/3209114.png'), fit: BoxFit.fill),
                  ),
                ),
                title: Text(
                  widget.pheight,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Height',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              width: 150,
              child: ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/128/1599/1599539.png'), fit: BoxFit.fill),
                  ),
                ),
                title: Text(
                  widget.pweight,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Weight',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'All Patient Records:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent),
                // color: Colors.amberAccent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Allergies'),
                ),
              ),
              MedicationCardList()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent),
                // color: Colors.amberAccent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Medications'),
                ),
              ),
              MedicationCardList()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey),
                // color: Colors.amberAccent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Immunizations'),
                ),
              ),
              MedicationCardList()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple),
                // color: Colors.amberAccent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Lab Results'),
                ),
              ),
              MedicationCardList()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent),
                // color: Colors.amberAccent,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Additional Notes'),
                ),
              ),
              MedicationCardList()
            ],
          ),
        ),
        Text("$_start"),
        Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  width: SizeConfig.screenWidth / 4,
                  height: 50,
                  child: CustomButton(
                    title: 'Start Service',
                    onPress: () {
                      startTimer();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  width: SizeConfig.screenWidth / 4,
                  height: 50,
                  child: CustomButton(
                    title: 'Stop Service',
                    onPress: () async {
                      try{
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var response =
                        await Utils().completeAppointmnet(widget.appoint_id);
                        if (response['status'] == false) {
                          _timer?.cancel();
                          await EasyLoading.showError(
                              response['appointment']);
                        } else {
                          _timer?.cancel();
                          await EasyLoading.showSuccess(
                              response['appointment']);
                          Navigator.of(context).pushReplacementNamed('/proof_work');
                        }
                      }
                      catch(e){
                        _timer?.cancel();
                        await EasyLoading.showError(e.toString());
                      }

                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
