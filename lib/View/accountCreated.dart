import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';

class AccountCreated extends StatefulWidget {
  @override
  _AccountCreatedState createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight * 1,
        child: ListView(children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.6,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/nurse.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Account Created', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blueAccent),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Your account has been created successfully click continue to log into your account.', style: TextStyle(fontSize: 18, color: Colors.grey), textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(title: 'Go to Homepage', onPress: (){
              Navigator.of(context).pushReplacementNamed('/home');
            }
            ),
          ),
        ]),
      ),
    );
  }
}
