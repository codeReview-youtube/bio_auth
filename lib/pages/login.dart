import 'package:bio_auth/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

const paddingValue = 50.0;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool isBioExist = false;

  bool get isValid {
    if (email.length > 10 && email.contains('@') && password.length > 8) {
      return true;
    }
    return true;
  }

  Future<bool> get hasBio async {
    List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();
    return availableBiometrics.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade700,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 220),
            Container(
              padding: EdgeInsets.only(left: paddingValue),
              alignment: Alignment.centerLeft,
              child: Text(
                'Login with:',
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
                cursorColor: Colors.pink,
                enableSuggestions: true,
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
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
                style: TextStyle(color: Colors.indigo),
                onChanged: (val) {
                  this.setState(() {
                    password = val;
                  });
                },
                cursorColor: Colors.pink,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                if (this.isValid) {
                  // login
                }
              },
              tooltip: 'Login in',
              backgroundColor: this.isValid ? Colors.indigo : Colors.grey,
              child: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(
              height: 100,
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FloatingActionButton(
                    onPressed: () async {
                      bool isAuthenticated = await localAuth.authenticate(
                          localizedReason: 'Login');
                      if (isAuthenticated) {
                        Navigator.of(context).pushNamed('home');
                      } else {
                        // showError
                      }
                    },
                    tooltip: 'Bio login',
                    child: Icon(Icons.fingerprint),
                  );
                }
                return null;
              },
              future: this.hasBio,
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.indigo),
                  ),
                  onPressed: () =>
                      {Navigator.of(context).pushNamed('register')},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
