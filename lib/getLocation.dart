// import 'package:flutter/cupertino.dart';
// import 'package:location/location.dart';

// class GetLocation extends StatefulWidget {
//   GetLocation({Key? key}) : super(key: key);

//   @override
//   _GetLocationState createState() => _GetLocationState();
// }

// class _GetLocationState extends State<GetLocation> {
//   Location location = Location();
//   late PermissionStatus _permissionGranted;
//   late bool _serviceEnabled;
//   late LocationData _locationData;

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCurrentLocation();
//   }

// // This returns the current Latitude and Longtitude
//   Future<LocationData?> getCurrentLocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     while (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//     }
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       _permissionGranted = await location.requestPermission();
//       while (_permissionGranted != PermissionStatus.granted) {
//         _permissionGranted = await location.requestPermission();
//       }
//     }
//     _locationData = await location.getLocation();
//     print(_locationData);
//     return _locationData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text(_locationData.toString()));
//   }
// }
