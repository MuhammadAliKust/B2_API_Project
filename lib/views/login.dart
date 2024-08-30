import 'dart:developer';

import 'package:b2_api/services/auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    if (loginResponse.user != null) {
                      await AuthServices()
                          .getUserData(loginResponse.token.toString())
                          .then((userModel) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(userModel.user!.name.toString())));
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
