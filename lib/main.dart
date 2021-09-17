import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
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
        duration: Duration(milliseconds: 750), curve: Curves.linear);
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
