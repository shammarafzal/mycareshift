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
              Text('Thank you for uploading Documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You will be notified once your account has b verified', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
