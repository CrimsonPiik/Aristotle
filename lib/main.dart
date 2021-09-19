import 'dart:convert';
import 'dart:io';

import 'package:aristotle/generalFunctions/random_id_generator.dart';
import 'package:aristotle/globals.dart';
import 'package:aristotle/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:http/http.dart' as http;

import 'functions/shippingAddressFuncations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aristotle',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Aristotle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  bool _showBackToTopButton = false;

  Location location = Location();
  late PermissionStatus _permissionGranted;
  late bool _serviceEnabled;
  late LocationData _locationData;

  @override
  void initState() {
    super.initState();
    lookupUserCountry();
    getCurrentLocation();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 550), curve: Curves.linear);
  }

  Future<Map<String, dynamic>> lookupUserCountry() async {
    final response =
        await http.get(Uri.parse('https://api.ipregistry.co?key=tryout'));

    if (response.statusCode == 200) {
      userDetails = {
        'ip': json.decode(response.body)['ip'],
        'hostname': json.decode(response.body)['hostname'],
        'country': json.decode(response.body)['location']['country']['name'],
        'city': json.decode(response.body)['location']['city'],
        'header': json.decode(response.body)['user_agent']['header'],
        'brand': json.decode(response.body)['user_agent']['device']['brand'],
        'name': json.decode(response.body)['user_agent']['device']['name'],
        'security': json.decode(response.body)['security'],
      };
      return userDetails;
    } else {
      throw Exception('Failed to get user!');
    }
  }

  // This returns the current Latitude and Longtitude
  Future<LocationData?> getCurrentLocation() async {
    if (!kIsWeb) {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
    convertAddress(_locationData);

    return _locationData;
  }

  Future<Map> convertAddress(LocationData _locationData) async {
    Address reverseGeo = await reverseGeocode(LatLng(
        _locationData.latitude ?? 31.96505333911774,
        _locationData.longitude ?? 35.84323115682168));

    Address readableAddress = await humanReadableAddress(
        LatLng(_locationData.latitude ?? 31.96505333911774,
            _locationData.longitude ?? 35.84323115682168),
        reverseGeo);

    Map<String, dynamic> address = {
      'city': readableAddress.city,
      'country': readableAddress.country,
      'latitude': readableAddress.latitude,
      'longitude': readableAddress.longitude,
      'neighbourhood': readableAddress.neighbourhood,
    };
    addAddressToExistingUser(address);

    return address;
  }

  /// This function will update address for an existing user in firebase
  Future<void> addAddressToExistingUser(Map<String, dynamic> address) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(generateId())
        .set({'address': address, 'userDetails': userDetails});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Container(
            child: Column(
              children: [
                Image.asset("assets/images/1.jpg"),
                Image.asset("assets/images/2.jpg"),
                Image.asset("assets/images/3.jpg"),
                Image.asset("assets/images/4.jpg"),
                Image.asset("assets/images/5.jpg"),
                Image.asset("assets/images/6.jpg"),
                Image.asset("assets/images/7.jpg"),
                Image.asset("assets/images/8.jpg"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _scrollToTop,
              child: Icon(
                Icons.arrow_upward_outlined,
                color: Colors.red,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
