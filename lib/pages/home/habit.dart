import 'package:flutter/material.dart';
// import 'package:todo_app_frontend/components_test/task_habit_test.dart';
import 'package:soul_habit/components/task_habit.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Center(
          child: ListView(
        children: const [TaskHabit()],
      )),
    );
  }
}
