import 'package:example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'dart:convert';

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
      body: Container(
        color: const Color(0xFFE1E1E1),
        height: double.infinity,
        child: LoadingOverlay(
          isLoading: isLoading,
          progressIndicator: const CircularProgressIndicator(),
          child: loginBody(),
        ),
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(),
          alignment: Alignment.center,
          child: TextFormField(
            controller: userController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Username or email',
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(),
          alignment: Alignment.center,
          child: TextFormField(
            controller: pwdController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                borderSide: BorderSide(color: Color.fromARGB(255, 204, 40, 40)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
        SizedBox(
            width: 80.0,
            height: 40.0,
            child: ElevatedButton(
              onPressed: onLogin,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFFF5252))),
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 12),
              ),
            )),
        const SizedBox(height: 16),
        const Text('Login with your social media account'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF3B5998),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(FontAwesome.facebook),
                iconSize: 15,
                color: Colors.white,
                onPressed: () {},
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF55ACEE),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(FontAwesome.twitter),
                iconSize: 15,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF0077B5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(FontAwesome.linkedin),
                iconSize: 15,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xFFDB4437),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(FontAwesome.google),
                iconSize: 15,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF3F729B),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(FontAwesome.instagram),
                iconSize: 15,
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {},
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
      print(data);

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
}
