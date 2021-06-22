import 'package:bio_auth/pages/home.dart';
import 'package:bio_auth/pages/Register.dart';
import 'package:bio_auth/pages/login.dart';
import 'package:bio_auth/pages/onboarding.dart';
import 'package:bio_auth/pages/passcod.dart';
import 'package:bio_auth/pages/setupPincode.dart';
import 'package:bio_auth/services/AuthenticationService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isNewUser = true;
  final authService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    // we need to set value
    final val = await authService.read('pin');
    if (val.isNotEmpty) {
      setState(() {
        isNewUser = false;
      });
    }
    this.authService.isNewUserController.add(isNewUser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: isNewUser ? RegisterPage() : PasscodePage(),
      routes: {
        'home': (builder) => MyHomePage(),
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'onboarding': (context) => OnboardingPage(),
        'setPincodeScreen': (context) => SetupPincode()
      },
    );
  }
}
