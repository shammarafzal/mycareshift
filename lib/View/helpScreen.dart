import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'helpDetails.dart';

class HelpCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: HelpScreen(
                question: 'Contact Us',
                question_details: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: HelpScreen(
                question: 'Report an Issue',
                question_details: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 5,
              child: HelpScreen(
                question: 'Recommend a friend',
                question_details: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class HelpScreen extends StatefulWidget {
  final String question;
  final String question_details;
  HelpScreen({
    required this.question,
    required this.question_details,
  });
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  HelpDetails(question_title: widget.question, question_details: widget.question_details,)
          ),
        );
      },
      child: ListTile(
        title: Text(widget.question),
      ),
    );
  }
}
