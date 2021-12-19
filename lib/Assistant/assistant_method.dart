import 'dart:convert';

import 'package:becaring/Models/direction_details.dart';
import 'package:becaring/View/config_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AssistantMethods{
  // static Future<String> searchCoordinateAddress(Position position, context) async{
  //   String placeAddress = "";
  //   String st1, st2, st3, st4;
  //   var url =  Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey");
  //   final response = await http.get(url);
  //   final decodeResponse = jsonDecode(response.body);
  //   if(decodeResponse != 'failed'){
  //     st1 = decodeResponse['results'][0]['address_components'][4]['long_name'];
  //     st2 = decodeResponse['results'][0]['address_components'][7]['long_name'];
  //     st3 = decodeResponse['results'][0]['address_components'][6]['long_name'];
  //     st4 = decodeResponse['results'][0]['address_components'][9]['long_name'];
  //     placeAddress = st1 + ", " + st1 + ", " + st2 + ", " + st3 + ", " + st4;
  //     Address userPickUpAddress = new Address();
  //     userPickUpAddress.lon
  // }
  // }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async{
        var directionUrl =  Uri.parse("https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey");
        final response = await http.get(directionUrl);
        print(response.body);
        final decodeResponse = jsonDecode(response.body);
        String epoints = decodeResponse["routes"][0]["overview_polyline"]["points"];
        String distext = decodeResponse["routes"][0]["legs"][0]["distance"]["text"];
        int disvalue = decodeResponse["routes"][0]["legs"][0]["distance"]["value"];
        String durtext = decodeResponse["routes"][0]["legs"][0]["duration"]["text"];
        int durvalue = decodeResponse["routes"][0]["legs"][0]["duration"]["value"];

          DirectionDetails directionDetails = DirectionDetails(distanceValue: disvalue, durationValue: durvalue, distanceText: distext, durationText: durtext, encodedPoints: epoints);
          return directionDetails;

  }
}