import 'dart:convert';
import 'dart:io';
import 'package:becaring/Models/get_appointment.dart';
import 'package:becaring/Models/get_booking.dart';
import 'package:becaring/Models/get_bookings_details.dart';
import 'package:becaring/Models/get_earning.dart';
import 'package:becaring/Models/get_help.dart';
import 'package:becaring/Models/get_me.dart';
import 'package:becaring/Models/get_notifications.dart';
import 'package:becaring/Models/get_rewards.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  static var client = http.Client();
  final String baseUrl = 'portal.mycareshift.com';
  var image_base_url = 'https://portal.mycareshift.com/storage/';

  verifyEmail(String email) async {
    var url = Uri.https(baseUrl, '/api/verifyEmail', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }

  checkToken(String email, String token) async {
    var url = Uri.https(baseUrl, '/api/verifyToken', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
      "token": token,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 400) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 404) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }

  registerNurse(
      String first_name,
      String last_name,
      String email,
      String password,
      String dob,
      String working_radius,
      String postal_code,
      String address,
      String phone,
      String token,
      String device_token,
      String promo_code,
      File imagePath,
      File identification_document,
      File dbs_certificate,
      File care_qualification_certificate
      ) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "https://portal.mycareshift.com/api/nurseRegister",
        ));
    request.fields["token"] = token;
    request.fields["device_token"] = device_token;
    request.fields["first_name"] = first_name;
    request.fields["last_name"] = last_name;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["dob"] = dob;
    request.fields["working_radius"] = working_radius;
    request.fields["postal_code"] = postal_code;
    request.fields["address"] = address;
    request.fields["phone"] = phone;
    request.fields["promo_code"] = promo_code;
    var imagePath_f = await http.MultipartFile.fromPath("image", imagePath.path);
    var identification_document_f = await http.MultipartFile.fromPath("identification_document", identification_document.path);
    var dbs_certificate_f = await http.MultipartFile.fromPath("dbs_certificate", dbs_certificate.path);
    var care_qualification_certificate_f = await http.MultipartFile.fromPath("care_qualification_certificate", care_qualification_certificate.path);

    request.files.add(imagePath_f);
    request.files.add(identification_document_f);
    request.files.add(dbs_certificate_f);
    request.files.add(care_qualification_certificate_f);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var decode = String.fromCharCodes(responseData);
    return jsonDecode(decode);
  }
  registerNurseDocs(
      String first_name,
      String last_name,
      String email,
      String password,
      String dob,
      String working_radius,
      String postal_code,
      String address,
      String phone,
      String token,
      String device_token,
      String promo_code,
      ) async {
    var url = Uri.https(baseUrl, '/api/nurseRegister', {"q": "dart"});
    final response = await http.post(url, body: {
      "token": token,
      "device_token": device_token,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "dob": dob,
      "working_radius": working_radius,
      "postal_code": postal_code,
      "address": address,
      "phone": phone,
      "promo_code": promo_code,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  uploadNurseDocs(
      File imagePath,
      File identification_document,
      File dbs_certificate,
      File care_qualification_certificate
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "https://portal.mycareshift.com/api/completeProfile",
        ));
    var imagePath_f = await http.MultipartFile.fromPath("image", imagePath.path);
    var identification_document_f = await http.MultipartFile.fromPath("identification_document", identification_document.path);
    var dbs_certificate_f = await http.MultipartFile.fromPath("dbs_certificate", dbs_certificate.path);
    var care_qualification_certificate_f = await http.MultipartFile.fromPath("care_qualification_certificate", care_qualification_certificate.path);
    request.headers.addAll(headers);
    request.files.add(imagePath_f);
    request.files.add(identification_document_f);
    request.files.add(dbs_certificate_f);
    request.files.add(care_qualification_certificate_f);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var decode = String.fromCharCodes(responseData);
    return jsonDecode(decode);
  }
  login(String email, String password) async {
    var url = Uri.https(baseUrl, '/api/nurseLogin', {"q": "dart"});
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  feedback(String name, String email, String message) async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/sendFeedback', {"q": "dart"});
    final response = await http.post(url, body: {
      "name": name,
      "email": email,
      "comments": message,
    }, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  Future<List<TrainingVideo>> getVideos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchTrainingVideos', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return trainingVideoFromJson(response.body);
    }
    else{
      return trainingVideoFromJson(response.statusCode.toString());
    }
  }
  Future<List<Help>> getHelp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchHelps', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return helpFromJson(response.body);
    }
    else{
      return helpFromJson(response.statusCode.toString());
    }
  }
  Future<List<Notification>> getNotifications() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchNotifications', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return notificationFromJson(response.body);
    }
    else{
      return notificationFromJson(response.statusCode.toString());
    }
  }
  Future<List<Me>> getMe() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/nurse', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return meFromJson(response.body);
    }
    else{
      return meFromJson(response.statusCode.toString());
    }
  }
  Future<List<Rewards>> getRewards() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchReward', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return rewardsFromJson(response.body);
    }
    else{
      return rewardsFromJson(response.statusCode.toString());
    }
  }
  Future<List<Appointment>> getAppointment() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var url = Uri.https(baseUrl, '/api/fetchAppointments', {"q": "dart"});

    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return appointmentFromJson(response.body);
    }
    else{
      return appointmentFromJson(response.statusCode.toString());
    }
  }
  Future<List<Booking>> getBooking() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchBookings', {"q": "dart"});
    var response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return bookingFromJson(response.body);
    }
    else{
      return bookingFromJson(response.statusCode.toString());
    }
  }

  bookAppointment(String patient_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/bookAppointment', {"q": "dart"});
    final response = await http.post(url, body: {
      "patient_id": patient_id,
    },headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  updateProfile(String phone, String location, String radius) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getInt('id');
    var url = Uri.https(baseUrl, '/api/nurseUpdate/${id}', {"q": "dart"});
    final response = await http.post(url, body: {
      "phone": phone,
      "working_radius": radius,
      "address": location,
    },headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }

  Future<List<BookingDetails>> getBookingDetails(String appointment_id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchAppointmentDetails', {"q": "dart"});
    var response = await client.post(url, body: {
      'appointment_id': appointment_id
    },headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return bookingDetailsFromJson(response.body);
    }
    else{
      return bookingDetailsFromJson(response.statusCode.toString());
    }
  }
  logout() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/nurseLogout', {"q": "dart"});
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }

  proofWork(
      String notes,
          String appointment_id,
      File imagePath,
      File signature,

      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "https://portal.mycareshift.com/api/completeAppointment",
        ));
    var imagePath_f = await http.MultipartFile.fromPath("photo", imagePath.path);
    var signature_f = await http.MultipartFile.fromPath("signature", signature.path);
    request.fields["note"] = notes;
    request.fields["appointment_id"] = appointment_id;
    request.headers.addAll(headers);
    request.files.add(imagePath_f);
    request.files.add(signature_f);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var decode = String.fromCharCodes(responseData);
    return jsonDecode(decode);
  }
  checkApprove() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/checkApprove', {"q": "dart"});
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 401) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 500) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      final String responseString = response.body;
      return jsonDecode(responseString);
    }
  }
  Future<List<Earning>> getEarning() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.https(baseUrl, '/api/fetchEarnings', {"q": "dart"});
    var response = await client.get(url,headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200){
      return earningFromJson(response.body);
    }
    else{
      return earningFromJson(response.statusCode.toString());
    }
  }
}