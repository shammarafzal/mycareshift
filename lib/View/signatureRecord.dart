import 'dart:typed_data';
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

class Sig extends StatefulWidget {
  @override
  _SigState createState() => _SigState();
}

class _SigState extends State<Sig> {
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

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) => Scaffold(
          body: ListView(
            children: <Widget>[
              Signature(
                controller: _controller,
                height: 200,
                backgroundColor: Colors.lightBlueAccent,
              ),
              Container(
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
                            // await Navigator.of(context).push(
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) {
                            //       return Scaffold(
                            //         appBar: AppBar(),
                            //         body: Center(
                            //           child: Container(
                            //             color: Colors.grey[300],
                            //             child: Image.memory(data),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
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
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}