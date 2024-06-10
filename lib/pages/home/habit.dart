import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:todo_app_frontend/components_test/task_habit_test.dart';
import 'package:soul_habit/components/task_habit.dart';
import 'package:soul_habit/services/remote/habit_services.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';
import 'package:soul_habit/models/habit.model.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  List<HabitModel> taskList = [];
  HabitAPI habitAPI = HabitAPI();

  @override
  void initState() {
    super.initState();
    _getHabitList();
    print('tasklist 3: $taskList');
  }

  void _getHabitList() {
    habitAPI.getHabitList(SharedPrefs.UserID!).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> listJson = jsonResponse['success'];
        List<HabitModel> tempTaskList =
            listJson.map((i) => HabitModel.fromJson(i)).toList();
        setState(() {
          taskList = tempTaskList;
          print('tastList 1: $taskList');
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((error) {
      print('Error: $error');
    });
    print('tastList 2: $taskList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C1C1C),
        body: Center(
            child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskHabit(task: taskList[index]);
                })));
  }
}
