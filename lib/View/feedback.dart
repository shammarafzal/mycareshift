import 'dart:async';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 100,
          child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/nurse.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Icon(Icons.arrow_back_ios, color: Colors.pink,),
                  ),
                ),
              )
          ),
        ),
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
                          'MyCareShift',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Feedback',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 22),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Name',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            child: CustomTextField(controller: _name,)
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
                                'Comments',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            child: CustomTextField(controller: _message, maxlines: 3,)
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(title: 'Send Feedback', onPress: () async {

                              try {
                                var response =
                                    await Utils().feedback(_name.text, _email.text, _message.text);
                                print(response);
                                if (response['status'] == false) {
                                  _timer?.cancel();
                                  await EasyLoading.showError(
                                      response['message']);
                                } else {
                                  _timer?.cancel();
                                  await EasyLoading.showSuccess(
                                      response['message']);
                                  Navigator.of(context).pop();
                                }
                              }
                              catch(e){
                                _timer?.cancel();
                                await EasyLoading.showError(
                                    e.toString());
                              }
                            },),
                          ),
                        ),
                      ],
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
