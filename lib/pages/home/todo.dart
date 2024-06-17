import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soul_habit/components/task_todo.dart';
import 'package:soul_habit/services/remote/todo_services.dart';

import '../../models/task_models/todo.model.dart';
import '../../services/local/shared_prefs.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<TodoModel> taskList = [];
  TodoAPI todoServices = TodoAPI();

  @override
  void initState() {
    super.initState();
    _getTodoList();
  }

  void _getTodoList() {
    todoServices.getTodoList(SharedPrefs.UserID!).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> listJson = jsonResponse['success'];
        List<TodoModel> tempTaskList =
            listJson.map((i) => TodoModel.fromJson(i)).toList();
        setState(() {
          taskList = tempTaskList;
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Center(
          child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return TaskTodo(task: taskList[index]);
        },
      )),
    );
  }
}
