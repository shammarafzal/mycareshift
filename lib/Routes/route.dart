import 'package:becaring/View/homePage.dart';
import 'package:becaring/View/signinScreen.dart';
import 'package:get/get.dart';


class Routes{
  static final routes = [
    GetPage(
      name: '/login',
      page: () => SignIn(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
  ];
}