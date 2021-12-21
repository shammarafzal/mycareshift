import 'package:becaring/Controllers/earning_controller.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningCardList extends StatelessWidget {
  final EarningController earningController = Get.put(EarningController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings'),
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() {
    return ListView.builder(
    itemCount: earningController.earningList.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, index) {
    return
    Card(
              color: Colors.white,
              elevation: 5,
              child: Earnings(
                date: earningController.earningList[index].startDate,
                payment_details: 'Payment Pending',
                ammount: '\£ ${earningController.earningList[index].bidHourlyRate}',
              ),
            );
    },
    );
        })
      ),
    );
  }
}

class Earnings extends StatefulWidget {
  final String date;
  final String payment_details;
  final String ammount;

  Earnings({
    required this.date,
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
