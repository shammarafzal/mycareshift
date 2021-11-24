import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Utils{
  final String baseUrl = 'mcsportal.spphotography.info';


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
      String date_of_interview,
      String address,
      String phone,
      String token,
      File identification_document,
      File dbs_certificate,
      File care_qualification_certificate
      ) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "http://mcsportal.spphotography.info/api/nurseRegister",
        ));
    request.fields["first_name"] = first_name;
    request.fields["last_name"] = last_name;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["dob"] = dob;
    request.fields["working_radius"] = working_radius;
    request.fields["postal_code"] = postal_code;
    request.fields["date_of_interview"] = date_of_interview;
    request.fields["address"] = address;
    request.fields["phone"] = phone;
    request.fields["token"] = token;
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
}