import 'dart:io';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:becaring/View/license_agreement.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:becaring/Models/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';

Widget _buildImage(String assetName, [double width = 350]) {
  return Image.asset('assets/$assetName', width: width);
}

final _fitstName = TextEditingController();
final _lastName = TextEditingController();
final _email = TextEditingController();
final _password = TextEditingController();
final _otp = TextEditingController();
final _postal_code = TextEditingController();
final _address = TextEditingController();
final _phone = TextEditingController();
final _promo = TextEditingController();
late String dob;
 String interview_date ="Not Verified";
late File imagePath;
late File identification_document;
late File dbs_certificate;
late File care_qualification_certificate;

int pinLength = 4;
bool hasError = false;

DateTime? _chosenDateTime;
DateTime? _chosenDateTime1;
CupertinoDatePickerMode mode = CupertinoDatePickerMode.date;

String radius = 'Select Radius';
var items_radius = [
  'Select Radius',
  '0-10 Miles',
  '11-20 Miles',
  '21-30 Miles'
];

bool IDOK = false;
bool DBSOK = false;
bool CareOK = false;
late String token;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


class SignupUser extends StatefulWidget {
  const SignupUser({Key? key}) : super(key: key);

  @override
  _SignupUserState createState() => _SignupUserState();
}

class _SignupUserState extends State<SignupUser> {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  @override
  void initState() {
    _totalNotifications = 0;
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.instance.getToken().then((value) {
      token = value!;
      print(token);
    });
    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return CustomEmail();
  }
}

class CustomEmail extends StatelessWidget {
  const CustomEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildImage('logo-app.png', 40),
                  Container(
                    height: 40,
                  ),
                  Text(
                    'What\'s your Email?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'You\'ll use this email to sign in to MyCareShift.',
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
                          'Email Address',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 230,
                          child: TextField(
                            autofocus:true,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () async {
                      if (_email.text == "") {
                        alertScreen()
                            .showAlertMsgDialog(context, "Please Enter Email");
                      } else {
                        var response = await Utils().verifyEmail(_email.text);
                        if (response['status'] == false) {
                          alertScreen()
                              .showAlertMsgDialog(context, response['message']);
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed('/custom_otp');
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOTP extends StatefulWidget {
  const CustomOTP({Key? key}) : super(key: key);

  @override
  State<CustomOTP> createState() => _CustomOTPState();
}

class _CustomOTPState extends State<CustomOTP> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_email',
                  ),
                  Text(
                    'OTP Veification',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please enter the 4 digit code that we sent to your email',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Container(
                        height: 100.0,
                        child: PinCodeTextField(
                          autofocus: true,
                          controller: _otp,
                          hideCharacter: true,
                          highlight: true,
                          highlightColor: Colors.grey,
                          defaultBorderColor: Colors.grey,
                          hasTextBorderColor: Colors.grey,
                          highlightPinBoxColor:
                              Color.fromRGBO(246, 247, 249, 1),
                          maxLength: pinLength,
                          hasError: hasError,
                          maskCharacter: "*",
                          onTextChanged: (text) {
                            setState(() {
                              hasError = false;
                            });
                          },
                          pinBoxWidth: SizeConfig.screenWidth / 6,
                          pinBoxHeight: 64,
                          wrapAlignment: WrapAlignment.spaceAround,
                          pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinBoxColor: Color.fromRGBO(246, 247, 249, 1),
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () async {
                      if (_otp.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Verification Code");
                      } else {
                        var response = await Utils().checkToken(_email.text, _otp.text);
                        if (response['status'] == false) {
                          alertScreen()
                              .showAlertMsgDialog(context, response['message']);
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed('/custom_password');
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPassword extends StatelessWidget {
  const CustomPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_otp',
                  ),
                  Text(
                    'Choose a password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'You\'ll use this password to log in to MyCareShift.',
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
                          'Password',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              autofocus:true,
                              controller: _password,
                              obscureText: true,
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (_password.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Password");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_name');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomName extends StatelessWidget {
  const CustomName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_password',
                  ),
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
                              autofocus:true,
                              textInputAction: TextInputAction.next,
                              controller: _fitstName,
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
                              controller: _lastName,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (_fitstName.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter First Name");
                      } else if (_lastName.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Last Name");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_dob');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDob extends StatefulWidget {
  const CustomDob({Key? key}) : super(key: key);

  @override
  State<CustomDob> createState() => _CustomDobState();
}

class _CustomDobState extends State<CustomDob> {
  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
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
                            dob =
                                '${val.day.toString()} ${val.month.toString()} ${val.year.toString()}';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_name',
                  ),
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
                            onTap: () {
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (_chosenDateTime == null) {
                        alertScreen()
                            .showAlertMsgDialog(context, "Please Choose D.o.B");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_address');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAddress extends StatefulWidget {
  const CustomAddress({Key? key}) : super(key: key);

  @override
  State<CustomAddress> createState() => _CustomAddressState();
}

class _CustomAddressState extends State<CustomAddress> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_dob',
                  ),
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
                              autofocus:true,
                              textInputAction: TextInputAction.next,
                              controller: _address,
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
                              controller: _postal_code,
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
                          child: DropdownButton(
                            value: radius,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: items_radius.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Center(
                                      child: Text(
                                    items,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  )));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                radius = newValue!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (_address.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Address");
                      } else if (_postal_code.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Postal Code");
                      } else if (radius == "Select Radius") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Select Working Radius");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_phone');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPhone extends StatelessWidget {
  const CustomPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_address',
                  ),
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
                              autofocus:true,
                              controller: _phone,
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (_phone.text == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Enter Phone Number");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_promo');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CustomPromo extends StatelessWidget {
  const CustomPromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_phone',
                  ),
                  Text(
                    'Enter Promo Code (optional)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please Enter Promo Code for discounts',
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
                          'Code',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 250,
                            child: TextField(
                              autofocus:true,
                              controller: _promo,
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_aggree');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAgree extends StatelessWidget {
  const CustomAgree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_phone',
                  ),
                  Text(
                    'Please Review Our Declaration',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please review the following before proceeding.',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new PrivacyPolicy(),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Text(
                            'Term and Conditions.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      )),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/custom_doc');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDoc extends StatelessWidget {
  const CustomDoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_aggree',
                  ),
                  Text(
                    'Documents',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please review the following before proceeding.',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new CustomID(),
                            ),
                          );
                        },
                        child: ListTile(
                          trailing: IDOK
                              ? Icon(Icons.done, color: Colors.green)
                              : Icon(Icons.cancel, color: Colors.red),
                          title: Text(
                            'Proof of ID',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          leading: Icon(Icons.account_box),
                        ),
                      )),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new CustomDBS(),
                            ),
                          );
                        },
                        child: ListTile(
                          trailing: DBSOK
                              ? Icon(Icons.done, color: Colors.green)
                              : Icon(Icons.cancel, color: Colors.red),
                          title: Text(
                            'DBS Certificate',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          leading: Icon(Icons.assignment_outlined),
                        ),
                      )),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new CustomCare(),
                            ),
                          );
                        },
                        child: ListTile(
                          trailing: CareOK
                              ? Icon(Icons.done, color: Colors.green)
                              : Icon(Icons.cancel, color: Colors.red),
                          title: Text(
                            'Care Qualification Certificate',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          leading: Icon(Icons.contact_mail),
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () async {
                      if (interview_date == "No date time picked!") {
                        alertScreen()
                            .showAlertMsgDialog(context, "Please Choose D.o.B");
                      } else {
                        var response = await Utils().registerNurse(
                          _fitstName.text,
                          _lastName.text,
                          _email.text,
                          _password.text,
                          dob,
                          radius,
                          _postal_code.text,
                          _address.text,
                          _phone.text,
                          _otp.text,
                          token,
                          _promo.text,
                          imagePath,
                          dbs_certificate,
                          care_qualification_certificate,

                        );
                        if (response["status"] == true) {
                          Navigator.of(context)
                              .pushReplacementNamed('/waiting_screen');
                        } else {
                          alertScreen()
                              .showAlertMsgDialog(context, response["message"]);
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomID extends StatefulWidget {
  const CustomID({Key? key}) : super(key: key);

  @override
  State<CustomID> createState() => _CustomIDState();
}

class _CustomIDState extends State<CustomID> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_doc',
                  ),
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
                    child: CustomButton(
                        title: 'Upload Document',
                        onPress: () async {
                          final picker = ImagePicker();
                          var image = await picker.getImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            imagePath = File(image.path);
                            setState(() {
                              IDOK = true;
                            });
                          } else {
                            alertScreen().showAlertMsgDialog(
                                context, "Failed to Upload ID picture");
                          }
                        }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (IDOK == false) {
                        print(imagePath);
                        print(identification_document);
                        alertScreen().showAlertMsgDialog(
                            context, "Please Upload I.D Image");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_doc');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDBS extends StatefulWidget {
  const CustomDBS({Key? key}) : super(key: key);

  @override
  State<CustomDBS> createState() => _CustomDBSState();
}

class _CustomDBSState extends State<CustomDBS> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_doc',
                  ),
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
                    child: CustomButton(
                        title: 'Upload DBS',
                        onPress: () async {
                          final picker = ImagePicker();
                          var image = await picker.getImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            dbs_certificate = File(image.path);
                            setState(() {
                              DBSOK = true;
                            });
                          } else {
                            alertScreen().showAlertMsgDialog(
                                context, "Failed to Upload D.B.S Image");
                          }
                        }),
                  ),
                  InkWell(
                    onTap: () {
                      alertScreen()
                          .showAlertDialog(context, 'Create DBS Certificate');
                    },
                    child: Text(
                      'I don\'t have this',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      // if (dbs_certificate.path == "") {
                      //   alertScreen().showAlertMsgDialog(
                      //       context, "Please Upload D.B.S Image");
                      // }
                      if (DBSOK == false) {
                        print(imagePath);
                        print(identification_document);
                        alertScreen().showAlertMsgDialog(
                            context, "Please Upload I.D Image");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_doc');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCare extends StatefulWidget {
  const CustomCare({Key? key}) : super(key: key);

  @override
  State<CustomCare> createState() => _CustomCareState();
}

class _CustomCareState extends State<CustomCare> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeader(
                    routeName: '/custom_doc',
                  ),
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
                    child: CustomButton(
                        title: 'Upload Certificate',
                        onPress: () async {
                          final picker = ImagePicker();
                          var image = await picker.getImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            care_qualification_certificate = File(image.path);
                            setState(() {
                              CareOK = true;
                            });
                          } else {
                            alertScreen().showAlertMsgDialog(context,
                                "Failed to Upload Care Certificate Image");
                          }
                        }),
                  ),
                  InkWell(
                    onTap: () {
                      alertScreen()
                          .showAlertDialog(context, 'Create Care Certificate');
                    },
                    child: Text(
                      'I don\'t have this',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      if (care_qualification_certificate.path == "") {
                        alertScreen().showAlertMsgDialog(
                            context, "Please Upload D.B.S Image");
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/custom_doc');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//
// class CustomInterview extends StatefulWidget {
//   const CustomInterview({Key? key}) : super(key: key);
//
//   @override
//   State<CustomInterview> createState() => _CustomInterviewState();
// }
//
// class _CustomInterviewState extends State<CustomInterview> {
//   void _showDatePicker(ctx) {
//     showCupertinoModalPopup(
//         context: ctx,
//         builder: (_) => Container(
//               height: 350,
//               color: Color.fromARGB(255, 255, 255, 255),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 250,
//                     child: CupertinoDatePicker(
//                         initialDateTime: DateTime.now(),
//                         mode: mode,
//                         onDateTimeChanged: (val) {
//                           setState(() {
//                             _chosenDateTime1 = val;
//                             interview_date =
//                                 '${val.day.toString()} ${val.month.toString()} ${val.year.toString()}';
//                           });
//                         }),
//                   ),
//
//                   // Close the modal
//                   CupertinoButton(
//                     child: Text('OK'),
//                     onPressed: () => Navigator.of(ctx).pop(),
//                   )
//                 ],
//               ),
//             ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   CustomHeader(
//                     routeName: 'custom_doc_list',
//                   ),
//                   Text(
//                     'Book Interview',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: Text(
//                       'Please pick a date to book interview!',
//                       style: TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.normal),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Date of Interview',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Center(
//                           child: InkWell(
//                             onTap: () {
//                               _showDatePicker(context);
//                             },
//                             child: Text(_chosenDateTime1 != null
//                                 ? '${_chosenDateTime1!.day.toString()} ${_chosenDateTime1!.month.toString()} ${_chosenDateTime1!.year.toString()}'
//                                 : 'No date time picked!'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(
//                     height: 2,
//                     color: Colors.black,
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: CustomButton(
//                     title: 'Continue',
//                     onPress: () async {
//                       final SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                       if (interview_date == "No date time picked!") {
//                         alertScreen()
//                             .showAlertMsgDialog(context, "Please Choose D.o.B");
//                       } else {
//                         var response = await Utils().registerNurse(
//                           _fitstName.text,
//                           _lastName.text,
//                           _email.text,
//                           _password.text,
//                           dob,
//                           radius,
//                           _postal_code.text,
//                           _address.text,
//                           _phone.text,
//                           _otp.text,
//                           token,
//                           _promo.text,
//                           imagePath,
//                           dbs_certificate,
//                           care_qualification_certificate,
//
//                         );
//                         if (response["status"] == true) {
//                           prefs.setString('id', response['nurse']['is_approved']);
//                           Navigator.of(context)
//                               .pushReplacementNamed('waiting_screen');
//                         } else {
//                           alertScreen()
//                               .showAlertMsgDialog(context, response["message"]);
//                         }
//                       }
//                     }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.routeName}) : super(key: key);
  final routeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(routeName);
              },
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
            _buildImage('logo-app.png', 40),
            Container(
              width: 40,
            )
          ],
        ),
        Container(height: 20)
      ],
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
