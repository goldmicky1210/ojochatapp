import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:loading_overlay/loading_overlay.dart';
import 'package:ojochat_app/components/auth_input.dart';
import 'package:ojochat_app/components/button.dart';
import 'package:ojochat_app/pages/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String _loginName = '';
  String _email = '';
  String _password = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/auth.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
              child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), BlendMode.srcATop),
            child: Container(color: Colors.white.withOpacity(0.85)),
          )),
          // Content
          LoadingOverlay(
            isLoading: isLoading,
            progressIndicator: const CircularProgressIndicator(),
            child: signUpBody(),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  signUpBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/logo.png',
            ),
            const SizedBox(width: 15),
            const Text(
              'OJOCHAT',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
          ]),
          const SizedBox(height: 20),
          const Text(
            'Create an account',
            style: TextStyle(fontSize: 15, fontFamily: 'Nunito, sans-serif'),
          ),
          const SizedBox(height: 20),
          CustomAuthInput(
              labelText: 'Username', controller: loginNameController),
          const SizedBox(height: 16),
          CustomAuthInput(
            labelText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomAuthInput(
              labelText: 'Password',
              controller: passwordController,
              obscureText: true),
          // const SizedBox(height: 16),
          // CustomAuthInput(
          //     labelText: 'Confirm Password',
          //     controller: confirmPasswordController,
          //     obscureText: true),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Sign Up',
            onPressed: onSignUp,
            width: 85.0,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(fontSize: 14),
              ),
              TextButton(
                onPressed: onSignIn,
                child: const Text(
                  'Sign in now!',
                  style: TextStyle(color: Color(0xFFFF5252), fontSize: 14),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onSignUp() async {
    setState(() {
      _loginName = loginNameController.text;
      _email = emailController.text;
      _password = passwordController.text;
      isLoading = true;
    });
    final response = await http
        .post(Uri.parse('http://localhost:8000/register'), body: {
      'loginName': _loginName,
      'email': _email,
      'password': _password
    });
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      final data = json.decode(response.body);
    }
  }

  void onSignIn() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage()));
  }
}
