import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:becaring/API/utils.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/Components/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';

class ProofWork extends StatefulWidget {
  @override
  _ProofWorkState createState() => _ProofWorkState();
}

class _ProofWorkState extends State<ProofWork> {

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }
  final arguments = Get.arguments as Map;
  Timer? _timer;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  final _notes = TextEditingController();
  File? imagePath;
  File? signature;

  _imgFromCamera() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imagePath = File(image!.path);
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagePath = File(image!.path);
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
              children: [
                Image.asset(
                  'assets/logo-app.png',
                  width: 100,
                  height: 100,
                ),
                // Text(
                //   'Be Caring',
                //   style: TextStyle(
                //       fontWeight: FontWeight.w600, fontSize: 22),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Proof of Work',
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
                        'Note',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                    child: CustomTextField(
                      controller: _notes,
                      maxlines: 3,
                    )),
                Signature(
                  controller: _controller,
                  height: 200,
                  backgroundColor: Colors.lightBlueAccent,
                ),
                Container(
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.blue,
                        onPressed: () async {
                          if (_controller.isNotEmpty) {
                            final Uint8List? data =
                                await _controller.toPngBytes();
                            if (data != null) {
                             String savePath = await getFilePath('my_img.png');
                              var sig = await File(savePath).writeAsBytes(data);
                              signature = sig;
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() => _controller.clear());
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Signature',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Attach Photo',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        _showPicker(context);
                      },
                    )),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: CustomButton(
                    title: 'Complete',
                    onPress: () async {
                      print(_notes.text);
                      print(arguments['appointment_id']);
                      print(imagePath);
                      print(signature);
                      try{
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var response =
                        await Utils().proofWork(_notes.text, arguments['appointment_id'],imagePath!, signature!, );
                        print(response);
                        if (response['status'] == false) {
                          _timer?.cancel();
                          await EasyLoading.showError(
                              response['appointment']);
                        }
                        else{
                          _timer?.cancel();
                          await EasyLoading.showSuccess(
                              response['appointment']);
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      }catch(e){
                        _timer?.cancel();
                        await EasyLoading.showError(e.toString());
                      }

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
