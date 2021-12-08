import 'dart:convert';
import 'dart:io';
import 'package:becaring/Models/get_help.dart';
import 'package:becaring/Models/get_me.dart';
import 'package:becaring/Models/get_notifications.dart';
import 'package:becaring/Models/get_videos.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Utils{

  static var client = http.Client();
  final String baseUrl = 'mcsportal.spphotography.info';
  var image_base_url = 'http://mcsportal.spphotography.info/storage/';

  verifyEmail(String email) async {
    var url = Uri.http(baseUrl, '/api/verifyEmail', {"q": "dart"});
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

  checkToken(String token) async {
    var url = Uri.http(baseUrl, '/api/verifyToken', {"q": "dart"});
    final response = await http.post(url, body: {
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
      File identification_document,
      File dbs_certificate,
      File care_qualification_certificate
      ) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "http://mcsportal.spphotography.info/api/nurseRegister",
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

    var identification_document_f = await http.MultipartFile.fromPath("identification_document", identification_document.path);
    var dbs_certificate_f = await http.MultipartFile.fromPath("dbs_certificate", dbs_certificate.path);
    var care_qualification_certificate_f = await http.MultipartFile.fromPath("care_qualification_certificate", care_qualification_certificate.path);
    request.files.add(identification_document_f);
    request.files.add(dbs_certificate_f);
    request.files.add(care_qualification_certificate_f);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var decode = String.fromCharCodes(responseData);
    print(jsonDecode(decode));
    return jsonDecode(decode);
  }
  login(String email, String password) async {
    var url = Uri.http(baseUrl, '/api/nurseLogin', {"q": "dart"});
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
    var url = Uri.http(baseUrl, '/api/sendFeedback', {"q": "dart"});
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
    var url = Uri.http(baseUrl, '/api/fetchTrainingVideos', {"q": "dart"});
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
    var url = Uri.http(baseUrl, '/api/fetchHelps', {"q": "dart"});
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
    var url = Uri.http(baseUrl, '/api/fetchNotifications', {"q": "dart"});
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
    var url = Uri.http(baseUrl, '/api/nurse', {"q": "dart"});
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

}