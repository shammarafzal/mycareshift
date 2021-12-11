import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 1 : SizeConfig.screenHeight * 1,
          width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 1 : SizeConfig.screenWidth * 1,
          // color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: Container(
                      height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.3 : SizeConfig.screenHeight * 0.3,
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 1 : SizeConfig.screenHeight * 1,
                      child: Image.asset('assets/logo-app.png')),
                    ),
              Text('Thank you for uploading Documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You will be notified once your account has been verified', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(title: 'Go Back', onPress: (){
                  Navigator.of(context).pushReplacementNamed('/login');
                }),
              )

            ],
          ),
        ),
      ),
    );
  }
}
