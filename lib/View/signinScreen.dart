import 'dart:async';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Timer? _timer;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: SizeConfig.screenHeight * 0.65,
                  child: ListView(
                    children: [
                      Image.asset(
                        'assets/logo-app.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'MyCareShift',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Email',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: CustomTextField(
                            controller: _email,
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Password',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: CustomTextField(
                            controller: _password,
                            isPassword: true,
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: CustomButton(
                            title: 'Login',
                            onPress: () async {
                              try {
                                final result = await InternetAddress.lookup(
                                    'google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  await EasyLoading.show(
                                    status: 'loading...',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var response = await Utils()
                                      .login(_email.text, _password.text);
                                  if (response['status'] == false) {
                                    _timer?.cancel();
                                    await EasyLoading.showError(
                                        response['message']);
                                  } else {
                                    prefs.setString('isApproved',
                                        response['nurse']['is_approved']);
                                    prefs.setBool('isLoggedIn', true);
                                    prefs.setString(
                                        'token', response['token']);
                                    prefs.setInt(
                                        'id', response['nurse']['id']);
                                    // if(response['nurse']['is_approved'] == "Not Approved"){
                                    //   Navigator.of(context).pushReplacementNamed('/waiting_screen');
                                    // }
                                    // else{
                                    //   Navigator.of(context).pushReplacementNamed('/home');
                                    // }
                                    _timer?.cancel();
                                    await EasyLoading.showSuccess(
                                        response['message']);
                                    Navigator.of(context)
                                        .pushReplacementNamed('/home');
                                  }
                                }
                              } on SocketException catch (e) {
                                _timer?.cancel();
                                await EasyLoading.showError('No Internet');
                              }
                              // catch(e){
                              //   _timer?.cancel();
                              //   await EasyLoading.showError(e.toString());
                              // }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: Text(
                  'Don\'t have an account? Register here.',
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
