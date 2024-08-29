import 'dart:convert';
import 'dart:developer';

import 'package:b2_api/models/login_response.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  ///Login
  Future<LoginResponseModel> loginUser(
      {required String email, required String pwd}) async {
    http.Response response = await http.post(
        Uri.parse("https://todo-nu-plum-19.vercel.app/users/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": pwd}));
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginResponseModel();
    }
  }

  ///Register
  ///Get User Data
  ///Update Profile
}
