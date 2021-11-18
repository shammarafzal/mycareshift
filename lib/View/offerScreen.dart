import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';

class OfferCardList extends StatelessWidget {
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
                child: Offers(
                  time: "10:00 AM - 12:00 PM",
                  hours: '3 HR',
                  ammount: '\£36.00',
                  address: 'London Uk ',
                  tip: '£12 p/h',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Offers extends StatefulWidget {
  final String time;
  final String hours;
  final String address;
  final String ammount;
  final String tip;
  Offers({
    required this.time,
    required this.hours,
    required this.address,
    required this.ammount,
    required this.tip,
  });

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        ListTile(
          title: Text(widget.time, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        ListTile(
          title: Text(widget.hours),
          trailing: Text(widget.ammount, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        ListTile(
          title: Text(widget.address),
          trailing: Text(widget.tip),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(title: 'Accept offer', onPress: (){
            Navigator.of(context).pushReplacementNamed('home');
          },),
        ),

      ],
    );
  }
}
