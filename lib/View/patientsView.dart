import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class PatientsCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Patients'),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pushReplacementNamed('home');
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: PatientsView(
                name: 'Ammar Afzal',
                address: "Room No 520, Floor No 13, Burj Al-Arab Dubai",
                phone: '+923216316351',
                disease: 'Persistent Cough',
                date: 'Dec 8, 2021',
                time: '7:30 AM',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: PatientsView(
                name: 'Alex',
                address: "London United kingdom",
                phone: '+443216316351',
                disease: 'Persistent Cough',
                date: 'Dec 8, 2021',
                time: '9:30 AM',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: PatientsView(
                name: 'Jason Roy',
                address: "New York America",
                phone: '+13216316351',
                disease: 'Persistent Cough',
                date: 'Dec 8, 2021',
                time: '11:30 AM',
              ),
            ),
          ],
        ),
      ),
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
  PatientsView({
    required this.name,
    required this.address,
    required this.phone,
    required this.disease,
    required this.date,
    required this.time,
  });
  @override
  _PatientsViewState createState() => _PatientsViewState();
}

class _PatientsViewState extends State<PatientsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      indicatorStyle: IndicatorStyle(color: Colors.blueAccent, width: 20, indicatorXY: 0, padding: EdgeInsets.all(1)),
      endChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_pin_sharp, color: Colors.blueAccent,),
              title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: Icon(Icons.maps_home_work_rounded, color: Colors.blueAccent,),
              title: Text(widget.address, style: TextStyle(),),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent,),
              title: Text(widget.phone, style: TextStyle(),),
            ),
            ListTile(
              leading: Icon(Icons.coronavirus, color: Colors.blueAccent,),
              title: Text(widget.disease, style: TextStyle(),),
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
                      child: CustomButton(title: 'Start Navigation', onPress: (){
                        Navigator.of(context).pushReplacementNamed('navigation_screen');
                      },),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      startChild: Container(
        child: Text(widget.time, style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
