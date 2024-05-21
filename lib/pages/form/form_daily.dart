import 'package:flutter/material.dart';

class FormDaily extends StatefulWidget {
  const FormDaily({super.key});

  @override
  State<FormDaily> createState() => _FormDailyState();
}

class _FormDailyState extends State<FormDaily> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF1C1C1C),
        body: Center(
          child: Text('Form Daily',
              style: TextStyle(fontSize: 40, color: Colors.white)),
        ));
  }
}
