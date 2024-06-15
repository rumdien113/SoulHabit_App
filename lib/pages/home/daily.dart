import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soul_habit/components/task_daily.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';
import 'package:soul_habit/services/remote/daily_services.dart';

import '../../models/task_models/daily.model.dart';

class Daily extends StatefulWidget {
  const Daily({super.key});

  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  List<DailyModel> taskList = [];
  DailyAPI dailyServices = DailyAPI();

  @override
  void initState() {
    super.initState();
    _getDailyList();
  }

  void _getDailyList() {
    dailyServices.getDailyList(SharedPrefs.UserID!).then((response) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> listJson = jsonResponse['success'];
        List<DailyModel> tempTaskList =
            listJson.map((i) => DailyModel.fromJson(i)).toList();
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
              // return const TaskDaily();
              return TaskDaily(task: taskList[index]);
            },
          ),
        ));
  }
}
