import 'dart:async';
import 'dart:io';

import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Settings/SizeConfig.dart';
import 'package:becaring/Settings/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

File? imagePath;
File? identification_document;
Timer? _timer;
File? dbs_certificate;
File? care_qualification_certificate;

bool IDOK = false;
bool DBSOK = false;
bool CareOK = false;
bool SelfieOK = false;

class CustomDocSubmit extends StatelessWidget {
  const CustomDocSubmit({Key? key}) : super(key: key);

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
                    routeName: '/home',
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
                                var response = await Utils().uploadNurseDocs(
                                  imagePath!,
                                  identification_document!,
                                  dbs_certificate!,
                                  care_qualification_certificate!,
                                );
                                if (response["status"] == true) {
                                  // print(response);
                                  // prefs.setString('token', response['token']);
                                  // prefs.setString('isApproved', response['nurse']['is_approved']);
                                  _timer?.cancel();
                                  await EasyLoading.showSuccess(
                                      'Thanks for Submitting documnets, You will be notified once your account will be approved.');
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                } else {
                                  _timer?.cancel();
                                  await EasyLoading.showError(
                                      response['message']);
                                }}
                                catch(e){

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
                    routeName: '/custom_doc_complete',
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
                          .pushReplacementNamed('/custom_doc_complete');
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
                    routeName: '/custom_doc_complete',
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
                          .pushReplacementNamed('/custom_doc_complete');
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
                    routeName: '/custom_doc_complete',
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
                          .pushReplacementNamed('/custom_doc_complete');
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
                    routeName: '/custom_doc_complete',
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
                          .pushReplacementNamed('/custom_doc_complete');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
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
Widget _buildImage(String assetName, [double width = 350]) {
  return Image.asset('assets/$assetName', width: width);
}