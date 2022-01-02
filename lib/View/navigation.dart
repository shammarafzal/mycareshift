// import 'dart:async';
// import 'dart:typed_data';
// import 'package:becaring/Assistant/assistant_method.dart';
// import 'package:becaring/Components/customButton.dart';
import 'dart:async';
import 'package:becaring/Assistant/assistant_method.dart';
import 'package:becaring/Components/customButton.dart';
import 'package:becaring/DataHandler/providers.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// var Plat = '';
// var Plng = '';
//
//
// class Navigation extends StatelessWidget {
//   final arguments = Get.arguments as Map;
//   @override
//   Widget build(BuildContext context) {
//     Plat = arguments['lat'];
//     Plng = arguments['lng'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//         leading: InkWell(
//             onTap: (){
//               Navigator.of(context).pushReplacementNamed('/patients_list');
//             },
//             child: Icon(Icons.arrow_back_ios)),
//       ),
//       body: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   List<LatLng> pLineCoordinates = [];
//   Set<Polyline> polyLinesSet = {};
//
//   StreamSubscription? _locationSubscription;
//   Location _locationTracker = Location();
//   Marker? marker;
//   Circle? circle;
//   GoogleMapController? _controller;
//
//   static final CameraPosition initialLocation = CameraPosition(
//     target: LatLng(30.173914950238814, 71.49491404232991),
//     zoom: 14.4746,
//   );
//
//   Future<Uint8List> getMarker() async {
//     ByteData byteData = await DefaultAssetBundle.of(context).load("assets/nurses.png");
//     return byteData.buffer.asUint8List();
//   }
//
//   void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
//     this.setState(() {
//       marker = Marker(
//           markerId: MarkerId("home"),
//           position: latlng,
//           rotation: newLocalData.heading!,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));
//       circle = Circle(
//           circleId: CircleId("car"),
//           radius: newLocalData.accuracy!,
//           zIndex: 1,
//           strokeColor: Colors.blue,
//           center: latlng,
//           fillColor: Colors.blue.withAlpha(70));
//     });
//   }
//
//   void getCurrentLocation() async {
//     try {
//
//       Uint8List imageData = await getMarker();
//       var location = await _locationTracker.getLocation();
//
//       updateMarkerAndCircle(location, imageData);
//
//       if (_locationSubscription != null) {
//         _locationSubscription?.cancel();
//       }
//
//
//       _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
//         if (_controller != null) {
//           _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//               bearing: 192.8334901395799,
//               target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
//               tilt: 0,
//               zoom: 18.00)));
//           updateMarkerAndCircle(newLocalData, imageData);
//         }
//       });
//
//
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     if (_locationSubscription != null) {
//       _locationSubscription?.cancel();
//     }
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             height: 400,
//             child: GoogleMap(
//               myLocationButtonEnabled: false,
//               mapType: MapType.hybrid,
//               initialCameraPosition: initialLocation,
//               markers: Set.of((marker != null) ? [marker!] : []),
//               circles: Set.of((circle != null) ? [circle!] : []),
//               polylines: polyLinesSet,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller = controller;
//               },
//
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: CustomButton(title: 'Arrived', onPress: (){
//               Navigator.of(context).pushReplacementNamed('/patients_details');
//             },),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.location_searching),
//           onPressed: () {
//             getCurrentLocation();
//             //getPlaceDirection();
//           }),
//     );
//   }
//   Future<void> getPlaceDirection() async{
//
//     var pickUpLatLng = LatLng(location.latitude!, location.longitude!);
//     print(Plng);
//     print(Plat);
//     var dropOffLatLng = LatLng(double.parse(Plat), double.parse(Plng));
//     // showDialog(context: context, builder: (BuildContext context) => ProgressDialog(me));
//     var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> decodePolyLinesPointsResults = polylinePoints.decodePolyline(details.encodedPoints);
//     pLineCoordinates.clear();
//     if(decodePolyLinesPointsResults.isNotEmpty){
//       decodePolyLinesPointsResults.forEach((PointLatLng pointLatLng) {
//         pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
//
//       });
//     }
//     polyLinesSet.clear();
//     setState(() {
//       Polyline polyline = Polyline(
//           color: Colors.red,
//           polylineId: PolylineId('PolyLineID'),
//           jointType: JointType.round,
//           points: pLineCoordinates,
//           startCap: Cap.roundCap,
//           endCap: Cap.roundCap,
//           geodesic: true
//       );
//       polyLinesSet.add(polyline);
//     });
//     LatLngBounds latLngBounds;
//     if(pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude){
//       latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
//     }
//     else if(pickUpLatLng.longitude > dropOffLatLng.longitude){
//       latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
//     }
//     else if(pickUpLatLng.latitude > dropOffLatLng.latitude){
//       latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
//     }
//     else{
//       latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
//     }
//     _controller!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
//
//   }
// }
class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final arguments = Get.arguments as Map;

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  Position? currentPosition;
  var geolocator = Geolocator();
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polyLinesSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  var detailGlobal;
  var detailGlobal1;
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latlnPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlnPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(30.1735893, 71.5089637), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        // leading: InkWell(
        //     onTap: () {
        //       Navigator.of(context).pushReplacementNamed('/patients_list');
        //     },
        //     child: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Stack(
              alignment: Alignment.center,
              children: [
            Container(
              height: 400,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: _kGooglePlex,
                polylines: polyLinesSet,
                markers: markersSet,
                circles: circlesSet,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
                  locatePosition();
                },
              ),
            ),
            detailGlobal != null ?
            Positioned(
                top: 20,
                child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12
                ),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const[
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0,2),
                        blurRadius: 6
                      )
                    ]
                  ),
                  child: Text('${detailGlobal} | ${detailGlobal1}'),
            )) : Text('')
          ]),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
              title: 'Navigate',
              onPress: () {
                getPlaceDirection();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              18.0,
            ),
            child: CustomButton(
              title: 'Arrived',
              colors: Colors.black,
              onPress: () {
                Provider.of<AppData>(context, listen: false).getTime(int.parse(arguments['duration'])* 60);
                Navigator.of(context).pushReplacementNamed('/patients_details', arguments: {'appointment_id': arguments['appointment_id']});
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var pickUpLatLng =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    var dropOffLatLng =
        LatLng(double.parse(arguments['lat']), double.parse(arguments['lng']));
    // showDialog(context: context, builder: (BuildContext context) => ProgressDialog(me));
    print(pickUpLatLng);
    print(dropOffLatLng);
    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);
    setState(() {
      detailGlobal = details.distanceText;
      detailGlobal1 = details.durationText;
    });
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinesPointsResults =
        polylinePoints.decodePolyline(details.encodedPoints);
    pLineCoordinates.clear();
    if (decodePolyLinesPointsResults.isNotEmpty) {
      decodePolyLinesPointsResults.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polyLinesSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Colors.red,
          polylineId: PolylineId('PolylineID'),
          width: 5,
          jointType: JointType.round,
          points: pLineCoordinates,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      polyLinesSet.add(polyline);
    });
    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }
    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    Marker pickupLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(snippet: 'My Location'),
        position: pickUpLatLng,
        markerId: MarkerId('pikupID'));
    Marker dropLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: 'Drop Off'),
        position: dropOffLatLng,
        markerId: MarkerId('dropID'));
    setState(() {
      markersSet.add(pickupLocationMarker);
      markersSet.add(dropLocationMarker);
    });

    Circle pickUpCircle = Circle(
        fillColor: Colors.yellow,
        center: pickUpLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.yellowAccent,
        circleId: CircleId('pickCirId'));
    Circle dropoffCircle = Circle(
        fillColor: Colors.red,
        center: dropOffLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.redAccent,
        circleId: CircleId('pickCirId'));
    setState(() {
      circlesSet.add(pickUpCircle);
      circlesSet.add(dropoffCircle);
    });
  }
}
