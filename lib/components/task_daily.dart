import 'package:flutter/material.dart';

class TaskDaily extends StatefulWidget {
  const TaskDaily({Key? key}) : super(key: key);

  @override
  _TaskDailyState createState() => _TaskDailyState();
}

class _TaskDailyState extends State<TaskDaily> {
  bool isChecked = false;

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
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.amber;
                    }
                    return null;
                  }),
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
            ),
            const SizedBox(width: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Task daily halakah',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Icon(Icons.double_arrow, color: Colors.grey, size: 15),
                  SizedBox(width: 5),
                  Text(
                    '17',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
