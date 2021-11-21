import 'package:becaring/View/accountCreated.dart';
import 'package:becaring/View/feedback.dart';
import 'package:becaring/View/helpScreen.dart';
import 'package:becaring/View/introductionScreen.dart';
import 'package:becaring/View/patientDetails.dart';
import 'package:becaring/View/proofOfWork.dart';
import 'package:becaring/View/signinScreen.dart';
import 'package:becaring/View/signupScreen.dart';
import 'package:becaring/View/verifycodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/homePage.dart';
import 'View/inbox.dart';
import 'View/inbox_list.dart';
import 'View/navigation.dart';
import 'View/new_signup.dart';
import 'View/patientsView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: isLoggedIn! ? 'home' : 'home',
      initialRoute: 'signup_screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {

        'login': (context) => SignIn(),
        'signup_screen': (context) => SignupUser(),
        'intro_screen': (context) => IntroScreen(),
        'home': (context) => HomePage(),
        'verify_code': (context) => VerificationCode(email: 'test'),
        'account_created': (context) => AccountCreated(),
        'feedback_screen': (context) => FeedBack(),
        'help_screen': (context) => HelpCardList(),
        'patients_list': (context) => PatientsCardList(),
        'patients_details_list': (context) => PatientDetailsCardList(),
        'navigation_screen': (context) => Navidation(),
        'proof_work': (context) => ProofWork(),
        'inbox': (context) => Inbox(),
        'inbox_list': (context) => ChatList(),
        'custom_email': (context) => CustomEmail(),
        'custom_otp': (context) => CustomOTP(),
        'custom_password': (context) => CustomPassword(),
        'custom_name': (context) => CustomName(),
        'custom_dob': (context) => CustomDob(),
        'custom_address': (context) => CustomAddress(),
        'custom_phone': (context) => CustomPhone(),
        'custom_agree_list': (context) => CustomAgree(),
        'custom_doc_list': (context) => CustomDoc(),
        'custom_interview': (context) => CustomInterview(),

      },
    ),
  );
}