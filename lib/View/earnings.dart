import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';

class EarningCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: 'Tuesday, Jan 24',
                time: "10:00 AM - 12:00 PM",
                payment_details: 'Payment Pending',
                ammount: '\$36.00 - \$50.00',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: 'Tuesday, Jan 24',
                time: "10:00 AM - 12:00 PM",
                payment_details: 'Payment Pending',
                ammount: '\$36.00 - \$50.00',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: 'Tuesday, Jan 24',
                time: "10:00 AM - 12:00 PM",
                payment_details: 'Payment Pending',
                ammount: '\$36.00 - \$50.00',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: 'Tuesday, Jan 24',
                time: "10:00 AM - 12:00 PM",
                payment_details: 'Payment Pending',
                ammount: '\$36.00 - \$50.00',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: 'Tuesday, Jan 24',
                time: "10:00 AM - 12:00 PM",
                payment_details: 'Payment Pending',
                ammount: '\$36.00 - \$50.00',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Earnings extends StatefulWidget {
  final String date;
  final String time;
  final String payment_details;
  final String ammount;

  Earnings({
    required this.date,
    required this.time,
    required this.payment_details,
    required this.ammount,
  });
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
          ListTile(
            title: Text(widget.date),
            trailing: Text(widget.ammount),
          ),

        ListTile(
          title: Text(widget.payment_details),
        )
      ],
    );
  }
}
