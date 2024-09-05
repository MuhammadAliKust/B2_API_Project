import 'package:b2_api/models/task.dart';
import 'package:b2_api/providers/token_provider.dart';
import 'package:b2_api/providers/user_provider.dart';
import 'package:b2_api/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskView extends StatefulWidget {
  final bool isUpdateMode;
  final Task model;

  const CreateTaskView(
      {super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateMode == true) {
      controller =
          TextEditingController(text: widget.model.description.toString());
    }

    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var token = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
          ),
          ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Task cannot be empty.")));
                  return;
                }
                try {
                  isLoading = true;
                  setState(() {});
                  if (widget.isUpdateMode) {
                    await TaskServices()
                        .updateTask(
                            token: token.getToken().toString(),
                            taskID: widget.model.id.toString(),
                            description: controller.text)
                        .then((val) {
                          isLoading = false;
                          setState(() {

                          });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(val.toString())));
                    });
                  }
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text("Update Task")),
        ],
      ),
    );
  }
}
