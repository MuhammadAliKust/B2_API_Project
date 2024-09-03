import 'package:b2_api/models/task.dart';
import 'package:b2_api/providers/token_provider.dart';
import 'package:b2_api/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var token = Provider.of<TokenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Get All Task View"),
        ),
        body: FutureProvider.value(
          value: TaskServices().getAllTasks(token.getToken().toString()),
          initialData: TaskModel(),
          builder: (context, child) {
            TaskModel taskModel = context.watch<TaskModel>();
            return taskModel.tasks == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(taskModel.tasks![i].description.toString()),
                      );
                    });
          },
        ));
  }
}
