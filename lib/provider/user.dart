import 'package:flutter/foundation.dart';
import 'package:skyz_islamabadz_backend/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  ///set User
  void setUser(UserModel model) {
    user = model;
    notifyListeners();
  }

  ///get User
  UserModel? getUser() => user;
}
