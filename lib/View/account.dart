import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _phone = TextEditingController();
  final _location = TextEditingController();
  String radius = 'Select Radius';
  var items_radius = [
    'Select Radius',
    '0-10 Miles',
    '11-20 Miles',
    '21-30 Miles'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 100,
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/nurse.png"),
                  fit: BoxFit.cover,
                ),
              ),
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
              )),
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
                          'Be Caring',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 22),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            child: CustomTextField(controller: _phone,)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Location',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                            child: CustomTextField(controller: _location,)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Working Radius',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
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
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: CustomButton(title: 'Update Profile', onPress: () async {
                             if (_phone.text == "") {
                              alertScreen().showAlertMsgDialog(
                                  context, "Please Enter Phone");
                            }
                             else if (_location.text == "") {
                               alertScreen().showAlertMsgDialog(
                                   context, "Please Enter Address");
                             }
                             if (radius == "") {
                               alertScreen().showAlertMsgDialog(
                                   context, "Please Enter Working Radius");
                             }
                             else {
                              var response =
                                  await Utils().updateProfile(_phone.text, _location.text, radius);
                              if (response['status'] == false) {
                                alertScreen()
                                    .showAlertMsgDialog(context, response['message']);
                              } else {
                                  Navigator.of(context).pop();
                              }
                            }
                          },),
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
