import 'dart:convert';
import 'dart:developer';

import '../models/task.dart';

import 'package:http/http.dart' as http;

class TaskServices {
  ///Get All Tasks
  Future<TaskModel> getAllTasks(String token) async {
    http.Response response = await http.get(
      Uri.parse("https://todo-nu-plum-19.vercel.app/todos/get"),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  ///Update Task
  Future<String> updateTask(
      {required String token,
      required String taskID,
      required String description}) async {
    http.Response response = await http.patch(
        Uri.parse("https://todo-nu-plum-19.vercel.app/todos/update/$taskID"),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode({"description": description, "complete": true}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['message'];
    } else {
      return "Something went wrong";
    }
  }
}
