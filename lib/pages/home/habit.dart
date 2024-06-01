import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:todo_app_frontend/components_test/task_habit_test.dart';
import 'package:soul_habit/components/task_habit.dart';
import 'package:soul_habit/services/habit_services.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';
import 'package:soul_habit/models/habit.model.dart';
import 'package:http/http.dart' as http;
import 'package:soul_habit/utils/app_constant.dart';

// Future<List<HabitModel>> fetchHabit(http.Client client) async {
//   final response = await client
//       .get(Uri.parse(AppConstant.get_habit_list + SharedPrefs.user_id!));
//   return compute(parseHabit, response.body);
// }

// List<HabitModel> parseHabit(String responseBody) {
//   final parsed =
//       (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
//   return parsed.map<HabitModel>((json) => HabitModel.fromJson(json)).toList();
// }

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
    _getHabitList();
    super.initState();
  }

  void _getHabitList() {
    habitAPI.getHabitList(SharedPrefs.user_id!).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> listJson = jsonResponse['success'];
        List<HabitModel> tempTaskList =
            listJson.map((i) => HabitModel.fromJson(i)).toList();
        setState(() {
          taskList = tempTaskList;
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((onError) {
      print('Error occurredL: $onError');
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
              return TaskHabit(task: taskList[index]);
            }
          )
              
        // children: const [TaskHabit()],
      )
    );
  }
}
