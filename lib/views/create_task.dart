import 'package:b2_api/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskView extends StatelessWidget {
  const CreateTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Text(
        userProvider.getUserData()!.user!.email.toString(),
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
