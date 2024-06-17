import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soul_habit/pages/form/form_todo.dart';
import 'package:soul_habit/services/remote/todo_services.dart';

import '../models/task_models/todo.model.dart';
import '../pages/home/home.dart';

class TaskTodo extends StatefulWidget {
  const TaskTodo({super.key, required this.task});

  final TodoModel task;
  @override
  _TaskTodoState createState() => _TaskTodoState();
}

class _TaskTodoState extends State<TaskTodo> {
  bool isChecked = false;
  TodoAPI todoService = TodoAPI();

  @override
  void initState() {
    super.initState();
  }

  void deleteItem(String id) async {
    await todoService.deleteTodoTask(id).then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home(2)));
      } else {
        final data = jsonDecode(response.body);
        final message = data['message'];
        print(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.4,
              child: Checkbox(
                  value: isChecked,
                  side: const BorderSide(color: Colors.grey, width: 2),
                  shape: const CircleBorder(),
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color.fromARGB(255, 170, 9, 173);
                    }
                    return null;
                  }),
                  onChanged: (bool? value) {
                    deleteItem(widget.task.todo_id);
                  }),
            ),
            const SizedBox(width: 10),
            // TEXT
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormTodo(widget.task)))
                    },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: 385,
                          child: Text(widget.task.todo_title,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      SizedBox(
                          width: 385,
                          child: Text(widget.task.todo_note,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey))),
                    ])),
          ],
        ));
  }
}
