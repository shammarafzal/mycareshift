import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/cupertino.dart';

class DataInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      body: CompleteSignUp(),
    );
  }
}

class CompleteSignUp extends StatefulWidget {
  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  DateTime? _chosenDateTime;
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.date;

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) =>
            Container(
              height: 350,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: mode,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }
  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.pink,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: _buildImage('logo-app.png', 40),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ),
          ),
        ],
      ),
      pages: [
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'What\'s your legal name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'To confirm your identity, this should be the same as it appears on your photo ID or passport',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Last Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
            ),
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'When\'s your birthday?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'To confirm your identity, and to send you birthday wishes!',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Center(
                          child: InkWell(
                            onTap: (){
                              _showDatePicker(context);
                            },
                            child: Text(_chosenDateTime != null
                                ? '${_chosenDateTime!.day.toString()} ${_chosenDateTime!.month.toString()} ${_chosenDateTime!.year.toString()}'
                                : 'No date time picked!'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),

                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget:  Text(''),
        ),
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'What\'s your Phone Number',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Your Number must be correct for future updates on jobs',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
        ),
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'What\'s your Home Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'To confirm your identity, this should be the same as it appears on your photo ID or passport',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Postal Code',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Working Radius',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'In Miles'
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
        ),
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'Identity Verification',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please Upload your passport or ID Card',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: CustomButton(title: 'Upload Document', onPress: (){}),
                  ),

                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
        ),
        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'DBS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please Upload your DBS Certificate',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: CustomButton(title: 'Upload DBS', onPress: (){}),
                  ),
                  InkWell(
                    onTap: (){
                      alertScreen().showAlertDialog(context, 'Create DBS Certificate');
                    },
                    child: Text(
                      'I don\'t have this',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),


                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
        ),

        PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    'Care Qualification Certificate',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please Upload your Care Certificate',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: CustomButton(title: 'Upload Certificate', onPress: (){}),
                  ),
                  InkWell(
                    onTap: (){
                      alertScreen().showAlertDialog(context, 'Create Care Certificate');
                    },
                    child: Text(
                      'I don\'t have this',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            decoration: pageDecoration,
            bodyWidget: Text('')
        ),

        PageViewModel(
          titleWidget: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Text(
                  'Book Interview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Please pick a date to book interview!',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date of Interview',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            _showDatePicker(context);
                          },
                          child: Text(_chosenDateTime != null
                              ? '${_chosenDateTime!.day.toString()} ${_chosenDateTime!.month.toString()} ${_chosenDateTime!.year.toString()}'
                              : 'No date time picked!'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),

              ],
            ),
          ),
          decoration: pageDecoration,
          bodyWidget:  Text(''),
        ),


      ],
      onDone: () => _onIntroEnd(context),
      next: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blueAccent,
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
          ),
          onPressed: null,
        ),
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsFlex: 0,
      dotsDecorator: const DotsDecorator(
        size: Size(3.0, 3.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(3.0, 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
