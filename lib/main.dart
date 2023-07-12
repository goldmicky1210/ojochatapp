import 'package:ojochat_app/pages/login.dart';
import 'package:ojochat_app/pages/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        routes: {
          '/login': (BuildContext context) => const LoginPage(),
          '/register': (context) => const SignUpPage()
        },
        home: const LoginPage());
  }
}
