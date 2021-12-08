import 'package:becaring/Controllers/help_controller.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpDetails.dart';

class HelpCardList extends StatelessWidget {
  final HelpController helpController = Get.put(HelpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
     body: Container(child: Obx(() {
        return ListView.builder(
          itemCount: helpController.helpList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return Card(
                        color: Colors.white,
                        elevation: 5,
                        child: HelpScreen(
                          question: helpController.helpList[index].name,
                          question_details: helpController.helpList[index].description,
                        ),
                      );
          },
        );
      })),

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
