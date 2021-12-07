import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class alertScreen{
  _launchDBS() async {
    const url =
        "https://www.instagram.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  showAlertDialog(BuildContext context,String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("MyCareShift",style: TextStyle(fontSize: 20,color: Colors.pink,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color: Colors.white,),textAlign: TextAlign.center,),
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Yes"),
                onPressed: (){
                  _launchDBS();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("No"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
    ).then((value){
      // timer.cancel();
      // timer = null!;
    });
  }

  showAlertMsgDialog(BuildContext context,String msg) {
    Timer timer = Timer(Duration(milliseconds: 1000), (){
      Navigator.of(context, rootNavigator: true).pop();
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: new Text("MyCareShift",style: TextStyle(fontSize: 20,color: Colors.pink,),),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(msg,style: TextStyle(fontSize: 14,color: Colors.white,),textAlign: TextAlign.center,),
            ),
          ),
        )
    ).then((value){
      timer.cancel();
      timer = null!;
    });
  }
}