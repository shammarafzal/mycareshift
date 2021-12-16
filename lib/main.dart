import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/route.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/custom_doc',
        getPages: Routes.routes
    ),
  );

}
