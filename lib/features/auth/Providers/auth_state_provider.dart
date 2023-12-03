import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/enums/enums.dart';

class AuthSataProvider extends ChangeNotifier {
  AuthState authState = AuthState.notSet;

  changeAuthState({required AuthState newState}) {
    authState = newState;
    notifyListeners();
  }
}
