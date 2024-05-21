import 'package:flutter/material.dart';
import 'package:soul_habit/components/task_daily.dart';

class Daily extends StatefulWidget {
  const Daily({super.key});

  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C1C1C),
        body: Center(
          child: ListView(
            children: const [
              TaskDaily(),
            ],
          ),
        ));
  }
}
