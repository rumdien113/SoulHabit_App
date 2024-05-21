import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1C1C1C),
      body: Center(
        child: Text(
          'ToDo\'s screen',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
  }
}
