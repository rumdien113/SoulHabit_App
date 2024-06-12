import 'package:flutter/material.dart';
import 'package:soul_habit/services/remote/habit_services.dart';

import '../models/task_models/habit.model.dart';
import '../pages/form/form_habit.dart';

class TaskHabit extends StatefulWidget {
  const TaskHabit({super.key, required this.task});

  final HabitModel task;
  @override
  _TaskHabitState createState() => _TaskHabitState();
}

class _TaskHabitState extends State<TaskHabit> {
  bool isChecked = false;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.task.habit_counter;
  }

  HabitAPI habitServices = HabitAPI();

  Future<void> _Counter(String slug) async {
    await habitServices.counter(widget.task.habit_id!, slug).then((value) => {
          if (value.statusCode == 200)
            {
              setState(() {
                if (slug == 'increase') {
                  _counter++;
                } else {
                  _counter--;
                }
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
        ),
        child: IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // btn ADD
            ElevatedButton(
                onPressed: () => _Counter('increase'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: const Icon(Icons.add_circle_outline)),
            // TEXT
            TextButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormHabit(widget.task)))
                    },
                child: Column(children: <Widget>[
                  Expanded(
                      child: SizedBox(
                          width: 325,
                          child: Text(widget.task.habit_title,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)))),
                  Expanded(
                      child: SizedBox(
                          width: 325,
                          child: Text(widget.task.habit_note,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey)))),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 310,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(Icons.double_arrow_sharp,
                                color: Colors.grey),
                            Text(
                              _counter.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            )
                          ],
                        ),
                      )),
                ])),
            // btn SUB
            ElevatedButton(
                onPressed: () => _Counter('decrease'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.grey[800],
                  foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: const Icon(Icons.remove_circle_outline)),
          ],
        )));
  }
}
