import 'package:flutter/material.dart';
import 'package:location/location.dart';

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

  // This returns the current Latitude and Longtitude
  Future<LocationData?> getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    while (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
      while (_permissionGranted != PermissionStatus.granted) {
        _permissionGranted = await location.requestPermission();
      }
    }
    _locationData = await location.getLocation();
    print(_locationData);
    return _locationData;
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
