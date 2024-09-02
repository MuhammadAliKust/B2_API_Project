import 'package:b2_api/providers/user_provider.dart';
import 'package:b2_api/views/create_task.dart';
import 'package:b2_api/views/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
        },
        child: Icon(Icons.edit),
      ),
      body: Text(
        userProvider.getUserData()!.user!.name.toString(),
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
