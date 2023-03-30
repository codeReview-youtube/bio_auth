import 'package:bio_auth/services/AuthenticationService.dart';
import 'package:flutter/material.dart';

const paddingValue = 50.0;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String email = '';
  String password = '';

  bool get _isValid {
    if (email.length > 10 && email.contains('@') && password.length > 10) {
      return true;
    }
    return false; // TODO
  }

  Future<bool> get hasBioAuth async {
    return await localAuth.canCheckBiometrics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade700,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 220),
            Container(
              padding: EdgeInsets.only(left: paddingValue),
              alignment: Alignment.centerLeft,
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: paddingValue),
              child: TextField(
                cursorColor: Colors.indigo[900],
                enableSuggestions: true,
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
                decoration: InputDecoration(
                  hintText: 'Email@me.com',
                ),
                onChanged: (val) => {
                  this.setState(() {
                    email = val;
                  })
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                style: TextStyle(color: Colors.indigo[900]),
                onChanged: (val) {
                  this.setState(() {
                    password = val;
                  });
                },
                cursorColor: Colors.indigo[900],
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                if (this._isValid) {
                  final hasBio = await this.hasBioAuth;
                  if (hasBio) {
                    Navigator.pushNamed(context, 'onboarding',
                        arguments: ScreenArgs(email: this.email));
                  } else {
                    Navigator.pushNamed(context, 'home');
                  }
                }
              },
              tooltip: 'Login in',
              backgroundColor: this._isValid ? Colors.indigo : Colors.grey,
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArgs {
  final String email;

  ScreenArgs({this.email});
}
