import 'package:flutter/material.dart';

class MedicationCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
          color: Colors.white,
          child: ListView(
            children: [
              PateintMedicalHistory(name: 'Peanut Allergy',),
            ],
          ),
      ),
    );
  }
}

class PateintMedicalHistory extends StatefulWidget {
  final String name;

  PateintMedicalHistory({
    required this.name,
  });

  @override
  _PateintMedicalHistoryState createState() => _PateintMedicalHistoryState();
}

class _PateintMedicalHistoryState extends State<PateintMedicalHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    );
  }
}
