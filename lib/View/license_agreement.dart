import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}
class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Completer <WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !Navigator.of(context).userGestureInProgress,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('License Agreement'),
        ),
        body: WebView(
          initialUrl: 'https://mycareshift.com/agreement',
          onWebViewCreated: (WebViewController webViewController){
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
