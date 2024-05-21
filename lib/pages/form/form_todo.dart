import 'package:flutter/material.dart';

class FormTodo extends StatefulWidget {
  const FormTodo({super.key});

  @override
  State<FormTodo> createState() => _FormTodoState();
}

class _FormTodoState extends State<FormTodo> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF1C1C1C),
        body: Center(
          child: Text('Form Todo',
              style: TextStyle(fontSize: 40, color: Colors.white)),
        ));
  }
}
