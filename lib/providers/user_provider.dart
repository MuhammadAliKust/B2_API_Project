import 'package:b2_api/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserModel? getUserData() {
    return _userModel;
  }
}
