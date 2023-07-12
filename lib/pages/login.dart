import 'package:ojochat_app/components/auth_input.dart';
import 'package:ojochat_app/components/icon.dart';
import 'package:ojochat_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'dart:convert';

import 'package:ojochat_app/components/button.dart';
import 'package:ojochat_app/pages/signup.dart';

// components

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  String username = '';
  bool isLoading = false;
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
  }

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
            child: loginBody(),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  loginBody() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
          'Sign in',
          style: TextStyle(fontSize: 15, fontFamily: 'Nunito, sans-serif'),
        ),
        const SizedBox(height: 20),
        CustomAuthInput(
            labelText: 'Username or email', controller: userController),
        const SizedBox(height: 16),
        CustomAuthInput(
            labelText: 'Password',
            controller: pwdController,
            obscureText: true),
        // const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          // padding: const EdgeInsets.only(left: 0, right: 5),
          child: Row(
            children: [
              Transform.scale(
                scale: 0.7,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
              ),
              const Text(
                'Remember Me',
                style: TextStyle(fontSize: 12),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Color(0xFFFF5252), fontSize: 12),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(text: 'Sign in', onPressed: onLogin),
        const SizedBox(height: 16),
        const Text('Login with your social media account'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomIcon(
              iconData: FontAwesome.facebook,
              backgroundColor: Color(0xFF3B5998),
            ),
            const SizedBox(width: 10),
            const CustomIcon(
              iconData: FontAwesome.twitter,
              backgroundColor: Color(0xFF55ACEE),
            ),
            const SizedBox(width: 10),
            const CustomIcon(
              iconData: FontAwesome.linkedin,
              backgroundColor: Color(0xFF0077B5),
            ),
            const SizedBox(width: 10),
            const CustomIcon(
              iconData: FontAwesome.google,
              backgroundColor: Color(0xFFDB4437),
            ),
            const SizedBox(width: 10),
            const CustomIcon(
              iconData: FontAwesome.instagram,
              backgroundColor: Color(0xFF3F729B),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: onSignUp,
              child: const Text(
                'Sign up now!',
                style: TextStyle(color: Color(0xFFFF5252), fontSize: 12),
              ),
            )
          ],
        )
      ]),
    );
  }

  void onLogin() async {
    setState(() {
      username = userController.text;
      isLoading = true;
    });

    final response = await http.post(Uri.parse('http://localhost:8000/login'),
        body: {'email': userController.text, 'password': pwdController.text});

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["loggedin"] == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: Text(data["message"]),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK')),
              ],
            );
          },
        );
      }
    } else {
      // Login failed, show error message
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK')),
            ],
          );
        },
      );
    }
  }

  void onSignUp() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const SignUpPage()));
  }
}
