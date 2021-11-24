import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        body: Container(
          color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/logo-app.png')),
                    ),
              Text('MyCareShift', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Soon you will notify through email when your profile is approved', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
