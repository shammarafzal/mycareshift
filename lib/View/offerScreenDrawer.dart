import 'package:flutter/material.dart';
import 'offerScreen.dart';

class OfferScreenDrawer extends StatefulWidget {
  const OfferScreenDrawer({Key? key}) : super(key: key);
  @override
  _OfferScreenDrawerState createState() => _OfferScreenDrawerState();
}

class _OfferScreenDrawerState extends State<OfferScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      body: OfferCardList(),
    );
  }
}
