import 'dart:io';

import 'package:bio_auth/pages/Register.dart';
import 'package:bio_auth/services/AuthenticationService.dart';
import 'package:bio_auth/widgets/gradientwrapper.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _enabledFingerprint = false;

  String getEmailArg(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments as ScreenArgs;
    String email = args.email;
    if (email.indexOf('.') != -1) {
      return email.substring(0, email.indexOf('.'));
    }

    if (email.indexOf('@') != -1) {
      return email.substring(0, email.indexOf('@'));
    }

    return email;
  }

  void showBioMeteric() {
    localAuth.authenticate(localizedReason: 'Add Passcode?');
  }

  String get switchLabel => Platform.isIOS ? 'Face Id' : 'Touch Id';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GradientWrapper(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height * .3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Welcome ${this.getEmailArg(context)}",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),
            SwitchListTile(
              value: this._enabledFingerprint,
              onChanged: (val) {
                setState(() => this._enabledFingerprint = val);
                if (val) {
                  showBioMeteric();
                }
              },
              title: Text(
                'Enable $switchLabel',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                ),
              ),
              activeColor: Colors.green.shade200,
              secondary: Icon(
                Icons.fingerprint,
              ),
            ),
            SizedBox(height: 100),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'setPincodeScreen');
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '* You could enable it also in settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
