import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Models/get_address.dart';
import 'package:becaring/Models/place_prediction.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:becaring/View/license_agreement.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:becaring/Models/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'config_maps.dart';

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
// String interview_date ="Not Verified";
File? imagePath;
File? identification_document;

File? dbs_certificate;
File? care_qualification_certificate;

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
List<PlacePredictions> placePredictionList = [];
bool IDOK = false;
bool DBSOK = false;
bool CareOK = false;
bool SelfieOK = false;
late String token;
Timer? _timer;
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
                  CustomHeader(
                    routeName: '/welcome_screen',
                  ),
                  // _buildImage('logo-app.png', 40),
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
                            autofocus: true,
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
                      try {
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var response = await Utils().verifyEmail(_email.text);
                        if (response['status'] == false) {
                          _timer?.cancel();
                          await EasyLoading.showError(
                              response['message']);
                        } else {
                          _timer?.cancel();
                          await EasyLoading.showSuccess(
                              response['message']);
                          Navigator.of(context)
                              .pushReplacementNamed('/custom_otp');
                        }
                      }
                      catch(e){
                        _timer?.cancel();
                        await EasyLoading.showSuccess(
                            e.toString());
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
                    'OTP Verification',
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
                       try {
                         await EasyLoading.show(
                           status: 'loading...',
                           maskType: EasyLoadingMaskType.black,
                         );
                        var response =
                            await Utils().checkToken(_email.text, _otp.text);
                        if (response['status'] == false) {
                          _timer?.cancel();
                          await EasyLoading.showError(
                              response['message']);
                        } else {
                          _timer?.cancel();
                          await EasyLoading.showSuccess(
                              response['message']);
                          Navigator.of(context)
                              .pushReplacementNamed('/custom_password');
                        }
                      }
                      catch (e){
                        _timer?.cancel();
                        await EasyLoading.showSuccess(
                           e.toString());
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
                              autofocus: true,
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
                    onPress: () async {
                      if (_password.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Password');
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
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              controller: _fitstName,
                              textCapitalization: TextCapitalization.sentences,
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
                              textCapitalization: TextCapitalization.sentences,
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
                    onPress: () async {
                      if (_fitstName.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter First Name');
                      } else if (_lastName.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Last Name');
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
                    onPress: () async {
                      if (_chosenDateTime == null) {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter D.O.B');
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
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              controller: _address,
                              onChanged: (val) {
                                findPlace(val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            )),


                      ],
                    ),
                  ),
                  (placePredictionList.length > 0) ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: ListView.separated(
                      itemBuilder: (context, index){
                        return PredictionTile(placePrediction: placePredictionList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index)=> Divider(),
                      itemCount: placePredictionList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  ) : Container(),
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
                    onPress: () async {
                      if (_address.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Address');
                      } else if (_postal_code.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Postal Code');
                      } else if (radius == "Select Radius") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Working Radius');
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

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      var autoCompleteUrl = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey");
      final res = await http.get(autoCompleteUrl);
      if (res == "failed") {
        return;
      }
      final decodeResponse = jsonDecode(res.body);
      if (decodeResponse["status"] == "OK") {
        var predictions = decodeResponse["predictions"];
        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
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
                              autofocus: true,
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
                    onPress: () async {
                      if (_phone.text == "") {
                        _timer?.cancel();
                        await EasyLoading.showError(
                            'Please Enter Phone Number');
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
                              autofocus: true,
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CustomButton(
                            title: 'Skip',
                            colors: Colors.black,
                            onPress: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/custom_aggree');
                            }),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CustomButton(
                            title: 'Continue',
                            onPress: () async {
                              if (_promo.text == "") {
                                _timer?.cancel();
                                await EasyLoading.showError(
                                    'Please Enter Promo Code');
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed('/custom_aggree');
                              }
                            }),
                      ),
                    ),
                  ],
                ),
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
                    title: ' I agree to the terms and conditions',
                    onPress: () {
                      Navigator.of(context).pushReplacementNamed('/custom_doc');
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
                              builder: (context) => new CustomSelfie(),
                            ),
                          );
                        },
                        child: ListTile(
                          trailing: SelfieOK
                              ? Icon(Icons.done, color: Colors.green)
                              : Icon(Icons.cancel, color: Colors.red),
                          title: Text(
                            'Take a Selfie',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          leading: Icon(Icons.camera),
                        ),
                      )),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CustomButton(
                            title: 'Skip',
                            colors: Colors.black,
                            onPress: () async {
                              try {
                                await EasyLoading.show(
                                  status: 'loading...',
                                  maskType: EasyLoadingMaskType.black,
                                );
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                var response = await Utils().registerNurseDocs(
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
                                );
                                if (response["status"] == true) {
                                  print(response);
                                  prefs.setString('token', response['token']);
                                  prefs.setString('isApproved',
                                      response['nurse']['is_approved']);
                                  _timer?.cancel();
                                  await EasyLoading.showSuccess(
                                      response['message']);
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                } else {
                                  _timer?.cancel();
                                  await EasyLoading.showError(
                                     response['message']);
                                }
                              }
                              catch(e){
                                _timer?.cancel();
                                await EasyLoading.showError(
                                   e.toString());
                              }
                            }),
                      ),
                    ),
                    Container(
                        width: SizeConfig.screenWidth * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomButton(
                              title: 'Continue',
                              onPress: () async {
                                try{
                                  await EasyLoading.show(
                                    status: 'loading...',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
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
                                  imagePath!,
                                  identification_document!,
                                  dbs_certificate!,
                                  care_qualification_certificate!,
                                );
                                if (response["status"] == true) {
                                  print(response);
                                  prefs.setString('token', response['token']);
                                  prefs.setString('isApproved', response['nurse']['is_approved']);
                                  _timer?.cancel();
                                  await EasyLoading.showSuccess(
                                      response['message']);
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                } else {
                                  _timer?.cancel();
                                  await EasyLoading.showError(
                                      response['message']);
                                }
                                }
                                catch(e){
                                  _timer?.cancel();
                                  await EasyLoading.showError(
                                      e.toString());
                                }
                              }),
                        )),
                  ],
                ),
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
  _imgFromCamera() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      identification_document = File(image!.path);
      IDOK = true;
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      identification_document = File(image!.path);
      IDOK = true;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                          _showPicker(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 5,
                      child: identification_document != null
                          ? Image.file(
                              identification_document!,
                              width: 400,
                              height: SizeConfig.screenHeight * 0.3,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                    title: 'Continue',
                    onPress: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/custom_doc');
                      //Navigator.pop(context);
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
  _imgFromCamera() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      dbs_certificate = File(image!.path);
      DBSOK = true;
      print(DBSOK);
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      dbs_certificate = File(image!.path);
      DBSOK = true;
      print(DBSOK);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                          _showPicker(context);
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 5,
                      child: dbs_certificate != null
                          ? Image.file(
                              dbs_certificate!,
                              width: 400,
                              height: SizeConfig.screenHeight * 0.3,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
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

class CustomCare extends StatefulWidget {
  const CustomCare({Key? key}) : super(key: key);

  @override
  State<CustomCare> createState() => _CustomCareState();
}

class _CustomCareState extends State<CustomCare> {
  // late File _image;
  _imgFromCamera() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      care_qualification_certificate = File(image!.path);
      CareOK = true;
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      care_qualification_certificate = File(image!.path);
      CareOK = true;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                          _showPicker(context);
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 5,
                      child: care_qualification_certificate != null
                          ? Image.file(
                              care_qualification_certificate!,
                              width: 400,
                              height: SizeConfig.screenHeight * 0.3,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
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

class CustomSelfie extends StatefulWidget {
  const CustomSelfie({Key? key}) : super(key: key);

  @override
  State<CustomSelfie> createState() => _CustomSelfieState();
}

class _CustomSelfieState extends State<CustomSelfie> {
  // late File _image;
  _imgFromCamera() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imagePath = File(image!.path);
      SelfieOK = true;
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(image!.path);
      SelfieOK = true;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
                    routeName: '/custom_doc',
                  ),
                  Text(
                    'Take a Selfie',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Please Upload your Image',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: CustomButton(
                        title: 'Upload Image',
                        onPress: () async {
                          _showPicker(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 5,
                      child: imagePath != null
                          ? Image.file(
                              imagePath!,
                              width: 400,
                              height: SizeConfig.screenHeight * 0.3,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
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

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePrediction;

  const PredictionTile({Key? key, required this.placePrediction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getPlaceAddress(placePrediction.place_id);
      },
      child: Container(
          child: Column(children: [
        SizedBox(width: 10),
        Row(
          children: [
            Icon(Icons.add_location),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      placePrediction.main_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      placePrediction.secondary_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
        SizedBox(width: 10),
      ])),
    );
  }
   getPlaceAddress(String place_id) async{
    var placeAddress =  Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=$mapKey");
    final res = await http.get(placeAddress);
    if (res == "failed") {
      return;
    }
    final decodeResponse = jsonDecode(res.body);
    print(decodeResponse);
    if (decodeResponse["status"] == "OK") {
     Address address = Address(place_id: place_id, latitude: decodeResponse["result"]["geometry"]["location"]["lat"].toString(), longitude: decodeResponse["result"]["geometry"]["location"]["lng"].toString(), placeName: decodeResponse["result"]["name"] );
     _address.text = address.placeName;
     print(address.placeName);
    }
  }
}
