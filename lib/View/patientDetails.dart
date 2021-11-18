import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/View/patientMedications.dart';
import 'package:flutter/material.dart';

class PatientDetailsCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Patient Info'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            PatientInfo(
                name: 'Ammar Afzal',
                address: '03 Jean Court Suite LA',
                img: 'https://googleflutter.com/sample_image.jpg',
                dob: '12-12-1998',
                blood: 'B-',
                pheight: '178',
                pweight: '89',
                pdisease: 'Liver')
          ],
        ),
      ),
    );
  }
}

class PatientInfo extends StatefulWidget {
  final String name;
  final String address;
  final String img;
  final String dob;
  final String blood;
  final String pheight;
  final String pweight;
  final String pdisease;

  PatientInfo({
    required this.name,
    required this.address,
    required this.img,
    required this.dob,
    required this.blood,
    required this.pheight,
    required this.pweight,
    required this.pdisease,
  });

  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(widget.img), fit: BoxFit.fill),
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
                        image: NetworkImage(widget.img), fit: BoxFit.fill),
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
                        image: NetworkImage(widget.img), fit: BoxFit.fill),
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
                        image: NetworkImage(widget.img), fit: BoxFit.fill),
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
                        image: NetworkImage(widget.img), fit: BoxFit.fill),
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
                  color: Colors.amberAccent
                ),
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
                    color: Colors.blueAccent
                ),
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
                    color: Colors.blueGrey
                ),
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
                    color: Colors.purple
                ),
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
                    color: Colors.orangeAccent
                ),
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
                  child: CustomButton(title: 'Start Service', onPress: (){

                  },),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  width: SizeConfig.screenWidth / 4,
                  height: 50,
                  child: CustomButton(title: 'Stop Service', onPress: (){
                    Navigator.of(context).pushReplacementNamed('proof_work');
                  },),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
