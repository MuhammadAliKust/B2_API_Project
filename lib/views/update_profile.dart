import 'dart:developer';

import 'package:b2_api/providers/token_provider.dart';
import 'package:b2_api/providers/user_provider.dart';
import 'package:b2_api/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(
        text: userProvider.getUserData()!.user!.name.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthServices()
                      .updateProfile(
                          token: tokenProvider.getToken().toString(),
                          name: nameController.text)
                      .then((val) {
                    userProvider.setUser(val);
                    Navigator.pop(context);
                    log(val.toJson().toString());
                  });
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text("Update"))
        ],
      ),
    );
  }
}
