import 'package:flutter/material.dart';
import 'package:soul_habit/models/task_models/daily.model.dart';
import 'package:soul_habit/services/remote/daily_services.dart';

import '../pages/form/form_daily.dart';

class TaskDaily extends StatefulWidget {
  const TaskDaily({super.key, required this.task});

  final DailyModel task;
  @override
  _TaskDailyState createState() => _TaskDailyState();
}

class _TaskDailyState extends State<TaskDaily> {
  bool isChecked = false;
  int _counter = 0;
  DailyAPI dailyServices = DailyAPI();

  @override
  void initState() {
    super.initState();
    _counter = widget.task.daily_counter;
    if (widget.task.daily_state == true) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  Future<void> _Counter(String slug) async {
    await dailyServices.counter(widget.task.daily_id, slug).then((value) => {
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

  Future<void> _updateState(String state) async {
    await dailyServices
        .updateDailyState(widget.task.daily_id, state)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  setState(() {
                    if (state == 'true') {
                      isChecked = true;
                    } else {
                      isChecked = false;
                    }
                  })
                }
            });
  }

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
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color.fromARGB(255, 170, 9, 173);
                    }
                    return null;
                  }),
                  onChanged: (bool? value) {
                    if (value == true) {
                      _Counter('increase');
                      _updateState('true');
                    } else {
                      _Counter('decrease');
                      _updateState('false');
                    }
                    // setState(() {
                    //   isChecked = value!;
                    // });
                  }),
            ),
            const SizedBox(width: 10),
            // TEXT
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                              builder: (context) => FormDaily(widget.task)))
                    },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: 385,
                          child: Text(widget.task.daily_title,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      SizedBox(
                          width: 385,
                          child: Text(widget.task.daily_note,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey))),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 385,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Icon(Icons.double_arrow_sharp,
                                    color: Colors.grey),
                                Text(
                                  ' +$_counter',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                )
                              ],
                            ),
                          )),
                    ])),
          ],
        ));
  }
}
