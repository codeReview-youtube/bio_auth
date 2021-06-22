import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  static final localAuth = LocalAuthentication();
  final _storage = new FlutterSecureStorage();
  final StreamController<bool> _isEnabledController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isNewUserController =
      StreamController<bool>.broadcast();
  // Todo: skipped case
  // final StreamController<bool> _skipped

  StreamController<bool> get isEnabledController => _isEnabledController;
  StreamController<bool> get isNewUserController => _isNewUserController;

  Stream<bool> get isEnabledStream => _isEnabledController.stream;
  Stream<bool> get isNewUserStream => _isNewUserController.stream;

  Future<String> read(String key) async {
    final val = await this._storage.read(key: key);
    return val != null ? jsonDecode(val) : '';
  }

  Future<void> clearStorage() async {
    this._storage.delete(key: 'pin');
  }

  Future<void> write(String key, dynamic value) async {
    await this._storage.write(key: key, value: jsonEncode(value));
  }

  Future<void> verifyCode(String enteredCode) async {
    final pin = await this.read('pin');
    if (pin != null && pin == enteredCode) {
      this.isNewUserController.add(false);
    } else {
      this.isNewUserController.add(true);
      this.write('pin', enteredCode);
    }
    this.isEnabledController.add(true);
  }

  dispose() {
    this._isEnabledController.close();
    this._isNewUserController.close();
  }
}

final AuthenticationService authService = AuthenticationService();
final localAuth = AuthenticationService.localAuth;
