import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight * 1,
          width: SizeConfig.screenWidth * 1,
          // color: Colors.pinkAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.3 : SizeConfig.screenHeight * 0.3,
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 1 : SizeConfig.screenWidth * 1,
                  child: Container(
                      width: SizeConfig.screenWidth * 0.3,
                      height: SizeConfig.screenHeight * 0.3,
                      child: Image.asset('assets/logo-app.png'))),
              Container(
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.3 : SizeConfig.screenHeight * 0.3,
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 1 : SizeConfig.screenWidth * 1,
                  child: Text('Welcome to MyCareShift', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.25 : SizeConfig.screenHeight * 0.3,
                    width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 1 : SizeConfig.screenWidth * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.08 : SizeConfig.screenHeight * 0.15,
                            width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 0.4 : SizeConfig.screenWidth * 0.3,
                            child: CustomButton(title: 'Sign In', onPress: (){
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            }, colors: Color.fromRGBO(105,105,105,0.1), textColor: Colors.black,)),
                        Container(
                            height: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenHeight * 0.08 : SizeConfig.screenHeight * 0.15,
                            width: MediaQuery.of(context).orientation == Orientation.portrait ? SizeConfig.screenWidth * 0.4 : SizeConfig.screenWidth * 0.3,

                            child: CustomButton(title: 'Sign Up', onPress: (){
                              Navigator.of(context)
                                  .pushReplacementNamed('/signup');
                            },)),
                      ],
                    )

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
