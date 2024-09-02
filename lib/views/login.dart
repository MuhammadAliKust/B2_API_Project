import 'dart:developer';

import 'package:b2_api/providers/token_provider.dart';
import 'package:b2_api/providers/user_provider.dart';
import 'package:b2_api/services/auth.dart';
import 'package:b2_api/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("LOgin"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  AuthServices()
                      .loginUser(
                          email: emailController.text, pwd: pwdController.text)
                      .then((loginResponse) async {
                    tokenProvider.saveToken(loginResponse.token.toString());
                    if (loginResponse.user != null) {
                      await AuthServices()
                          .getUserData(loginResponse.token.toString())
                          .then((userModel) {
                        userProvider.setUser(userModel);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView()));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email or pwd is invalid.")));
                    }
                  });
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text("LOgin"))
        ],
      ),
    );
  }
}
