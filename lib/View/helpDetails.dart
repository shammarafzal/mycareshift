import 'package:flutter/material.dart';

class HelpDetails extends StatefulWidget {
  final String question_title;
  final String question_details;
  HelpDetails({
    required this.question_title,
    required this.question_details,
  });

  @override
  _HelpDetailsState createState() => _HelpDetailsState();
}

class _HelpDetailsState extends State<HelpDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Details'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(widget.question_title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.question_details, style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}
