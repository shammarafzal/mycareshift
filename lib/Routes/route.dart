import 'package:becaring/View/accountCreated.dart';
import 'package:becaring/View/feedback.dart';
import 'package:becaring/View/helpScreen.dart';
import 'package:becaring/View/homePage.dart';
import 'package:becaring/View/inbox.dart';
import 'package:becaring/View/inbox_list.dart';
import 'package:becaring/View/navigation.dart';
import 'package:becaring/View/new_signup.dart';
import 'package:becaring/View/patientDetails.dart';
import 'package:becaring/View/patientsView.dart';
import 'package:becaring/View/proofOfWork.dart';
import 'package:becaring/View/signinScreen.dart';
import 'package:becaring/View/waiting_screen.dart';
import 'package:becaring/View/welcome_screen.dart';
import 'package:get/get.dart';


class Routes{
  static final routes = [
    GetPage(
      name: '/login',
      page: () => SignIn(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupUser(),
    ),
    GetPage(
      name: '/account_created',
      page: () => AccountCreated(),
    ),
    GetPage(
      name: '/feedback',
      page: () => FeedBack(),
    ),
    GetPage(
      name: '/help',
      page: () => HelpCardList(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/patients_list',
      page: () => PatientsCardList(),
    ),
    GetPage(
      name: '/patients_details',
      page: () => PatientDetailsCardList(),
    ),
    GetPage(
      name: '/navigation',
      page: () => Navigation(),
    ),
    GetPage(
      name: '/proof_work',
      page: () => ProofWork(),
    ),
    GetPage(
      name: '/inbox',
      page: () => Inbox(),
    ),
    GetPage(
      name: '/inbox_list',
      page: () => ChatList(),
    ),
    GetPage(
      name: '/patients_list',
      page: () => PatientsCardList(),
    ),
    GetPage(
      name: '/custom_email',
      page: () => CustomEmail(),
    ),

    GetPage(
      name: '/custom_password',
      page: () => CustomPassword(),
    ),

    GetPage(
      name: '/custom_otp',
      page: () => CustomOTP(),
    ),

    GetPage(
      name: '/custom_name',
      page: () => CustomName(),
    ),

    GetPage(
      name: '/custom_dob',
      page: () => CustomDob(),
    ),

    GetPage(
      name: '/custom_address',
      page: () => CustomAddress(),
    ),

    GetPage(
      name: '/custom_phone',
      page: () => CustomPhone(),
    ),

    GetPage(
      name: '/custom_aggree',
      page: () => CustomAgree(),
    ),

    GetPage(
      name: '/custom_doc',
      page: () => CustomDoc(),
    ),

    GetPage(
      name: '/waiting_screen',
      page: () => WaitingScreen(),
    ),

    GetPage(
      name: '/welcome_screen',
      page: () => WelcomeScreen(),
    ),

    GetPage(
      name: '/custom_promo',
      page: () => CustomPromo(),
    ),
  ];
}

