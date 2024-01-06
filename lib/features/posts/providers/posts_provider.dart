import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';

class UserInfoProvider extends ChangeNotifier {
  DataState dataState = DataState.notSet;
  UserModel? user;

  getUserInfo({required String uid}) async {
    dataState = DataState.loading;
    try {
      user = await UserDbServices().getUser(uid);
      dataState = DataState.done;
      notifyListeners();
    } catch (e) {
      dataState = DataState.failure;
      notifyListeners();
    }
  }

  updateUerInfo({required UserModel user}) async {
    this.user = user;
    notifyListeners();
  }
}
