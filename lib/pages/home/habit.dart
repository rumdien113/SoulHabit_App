import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
// import 'package:todo_app_frontend/components_test/task_habit_test.dart';
import 'package:soul_habit/components/task_habit.dart';
import 'package:soul_habit/config.dart';
import 'package:soul_habit/models/habit.model.dart';

class Habit extends StatefulWidget {
  final token;
  const Habit({@required this.token, super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  late String userId;
  List<HabitModel> items = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];
    // getHabitList(userId);
  }

  // void getHabitList(userId) async {
  //   print('userID: $userId');

  //   var response = await http.get(Uri.parse(get_habit_list + userId),
  //       headers: {"Content-Type": "application/json"});

  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     items = jsonResponse['success'];
  //     print(items);
  //   } else {
  //     print(response.statusCode);
  //   }

  //   setState(() {});
  // }

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
