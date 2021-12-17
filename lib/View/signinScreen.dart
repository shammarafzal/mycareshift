import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
        Expanded(
          child: ListView(
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
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logo-app.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          'Be Caring',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Sign In',
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
                            child: CustomTextField(controller: _email,)
                        ),
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
                            child: CustomTextField(controller: _password, isPassword: true,)
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: CustomButton(title: 'Login', onPress: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_email.text);
                            if (_email.text == "") {
                              alertScreen()
                                  .showAlertMsgDialog(context, "Please Enter Email");
                            } else if (emailValid == false) {
                              alertScreen().showAlertMsgDialog(
                                  context, "Please Enter Valid Email");
                            } else if (_password.text == "") {
                              alertScreen().showAlertMsgDialog(
                                  context, "Please Enter Password");
                            } else if (_password.text.length <= 7) {
                              alertScreen().showAlertMsgDialog(
                                  context, "Please Length Must Greater than 8");
                            } else {
                              var response =
                                  await Utils().login(_email.text, _password.text);
                              if (response['status'] == false) {
                                alertScreen()
                                    .showAlertMsgDialog(context, response['message']);
                              } else {
                                prefs.setString('isApproved', response['nurse']['is_approved']);
                                prefs.setBool('isLoggedIn', true);
                                prefs.setString('token', response['token']);
                                prefs.setInt('id', response['nurse']['id']);
                                // if(response['nurse']['is_approved'] == "Not Approved"){
                                //   Navigator.of(context).pushReplacementNamed('/waiting_screen');
                                // }
                                // else{
                                //   Navigator.of(context).pushReplacementNamed('/home');
                                // }
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            }

                          },),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed('/signup');
                    },
                    child: Text(
                      'Don\'t have an account? Register here.',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
