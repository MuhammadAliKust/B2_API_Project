import 'dart:convert';
import 'dart:developer';

import 'package:b2_api/models/user.dart' as MyUser;
import 'package:http/http.dart' as http;

import '../models/login_response.dart';

class AuthServices {
  ///Login
  Future<LoginResponseModel> loginUser(
      {required String email, required String pwd}) async {
    http.Response response = await http.post(
        Uri.parse("https://todo-nu-plum-19.vercel.app/users/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": pwd}));
    log("Login API");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginResponseModel();
    }
  }

  ///Register
  ///Get User Data
  Future<MyUser.UserModel> getUserData(String token) async {
    http.Response response = await http.get(
      Uri.parse("https://todo-nu-plum-19.vercel.app/users/profile"),
      headers: {'Authorization': token},
    );
    log("Get User API");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MyUser.UserModel.fromJson(jsonDecode(response.body));
    } else {
      return MyUser.UserModel();
    }
  }

  ///Update Profile
  Future<MyUser.UserModel> updateProfile(
      {required String token, required String name}) async {
    http.Response response = await http.put(
        Uri.parse("https://todo-nu-plum-19.vercel.app/users/profile"),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}));
    log("Get User API");
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // return UserModel();
      log(jsonDecode(response.body)['updatedUser'].toString());
      return MyUser.UserModel(
          status: true,
          user: MyUser.User.fromJson(jsonDecode(response.body)['updatedUser']));
    } else {
      return MyUser.UserModel();
    }
  }
}
