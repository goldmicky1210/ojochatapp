import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:loading_overlay/loading_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const Center(
          child: Text('Home'),
        ));
  }
}
