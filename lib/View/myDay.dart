import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/View/patientsView.dart';
import 'package:flutter/material.dart';

class MyDayCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: MyDay(
                  date: '10-Nov-2021',
                  time: "10:00 AM - 12:00 PM",
                  noOfPatients: '3',
                  ammount: '130',
                ),
              ),
            ),
          ],
        ),
      ),
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
          title: Text(widget.date, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: SizeConfig.screenWidth / 3,
                  child: Text('No of Patients', style: TextStyle(fontSize: 12, color: Colors.grey),textAlign: TextAlign.center,)),
              Container(
                width: 1,
                height: double.maxFinite,
                color: Colors.grey,
              ),
              Container(
                  width: SizeConfig.screenWidth / 3,
                  child: Text('Amount', style: TextStyle(fontSize: 12, color: Colors.grey),textAlign: TextAlign.center,)),
              Container(
                width: 1,
                height: double.maxFinite,
                color: Colors.grey,
              ),
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text('Time', style: TextStyle(fontSize: 12, color: Colors.grey),textAlign: TextAlign.center,))
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
                  child: Text(widget.noOfPatients, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              Container(
                width: SizeConfig.screenWidth / 4,
                  child: Text(widget.ammount, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              Container(
                  width: SizeConfig.screenWidth / 4,
                  child: Text(widget.time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.right,)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(title: 'View Details', onPress: (){
            Navigator.of(context).pushReplacementNamed('patients_list');
          },),
        ),
      ],
    );
  }
}
