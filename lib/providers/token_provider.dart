import 'package:b2_api/models/user.dart';
import 'package:flutter/cupertino.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  void saveToken(String token) {
    _token = token;
    notifyListeners();
  }

  String? getToken() {
    return _token;
  }
}
