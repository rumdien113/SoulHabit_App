import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task_models/daily.model.dart';

class FormDaily extends StatefulWidget {
  const FormDaily(this.task, {super.key});

  final DailyModel? task;
  @override
  State<FormDaily> createState() => _FormDailyState();
}

class _FormDailyState extends State<FormDaily> {
  //controller
  late final TextEditingController _dailyTitle =
      TextEditingController(text: widget.task?.daily_title);
  late final TextEditingController _dailyNotes =
      TextEditingController(text: widget.task?.daily_note);
  late final TextEditingController _dailyDifficulty = TextEditingController();
  late final TextEditingController _dailyStartDate = TextEditingController(
      text: DateFormat('MMM d, yyyy').format(DateTime.now()));
  late final TextEditingController _dailyRepeats = TextEditingController();
  late final TextEditingController _dailyEvery = TextEditingController();

  //array
  final List<String> _repeatList = [];
  final List<RadioModel> _levelList = [];
  List? items;

  //var
  String? _curRepeat = '';

  @override
  void initState() {
    super.initState();

    // Repeats
    _repeatList.add('Daily');
    _repeatList.add('Weekly');
    _repeatList.add('Monthly');
    _repeatList.add('Yearly');
    widget.task == null
        ? _curRepeat = _repeatList[0]
        : _curRepeat = widget.task?.daily_repeats;

    // Difficulty
    _levelList.add(RadioModel(false, 'Trivial', 'trivial_off', 'trivial_on'));
    _levelList.add(RadioModel(false, 'Easy', 'easy_off', 'easy_on'));
    _levelList.add(RadioModel(false, 'Medium', 'medium_off', 'medium_on'));
    _levelList.add(RadioModel(false, 'Hard', 'hard_off', 'hard_on'));
    for (var i in _levelList) {
      if (i.buttonText == widget.task?.daily_difficulty) {
        i.isSelected = true;
        _dailyDifficulty.text = i.buttonText;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
          title: widget.task == null
              ? const Text('Create Daily',
                  style: TextStyle(color: Colors.white))
              : const Text('Update Daily',
                  style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF6132B4),
          iconTheme: const IconThemeData(color: Colors.white),
          // ignore: unnecessary_null_comparison
          actions: widget.task != null
              ? <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 25)),
                    onPressed: () {
                      print("Delete");
                      // deleteItem(widget.task?.habit_id);
                    },
                    child: const Text('DELETE',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 25)),
                    onPressed: () {
                      print("Update");
                      // updateItem();
                    },
                    child: const Text('UPDATE',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ]
              : <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 25)),
                    onPressed: () {
                      print("Create");
                      // addHabit();
                    },
                    child: const Text('CREATE',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
                ]),
      body: ListView(children: [
        Container(
            height: 240,
            color: const Color(0xFF6132B4),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _dailyTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 67, 67, 67),
                      label: Text(
                        "Daily Title",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _dailyNotes,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 67, 67, 67),
                      label: Text(
                        "Notes",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                )
              ],
            )),
        const SizedBox(height: 20),
        Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            child: Column(children: <Widget>[
              // Difficulty
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Difficulty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _levelList
                    .map((e) => InkWell(
                          // focusColor: Colors.transparent,
                          overlayColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.transparent),
                          onTap: () {
                            _dailyDifficulty.text = e.buttonText;
                            setState(() {
                              for (var element in _levelList) {
                                element.isSelected = false;
                              }
                              e.isSelected = true;
                            });
                          },
                          child: RadioImage(e),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              // Start Date
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Scheduling',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ),
              const SizedBox(height: 10),
              // Start Date
              TextFormField(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(3000),
                  );
                  if (pickedDate != null) {
                    // format the picked date and set it as the field's value
                    String formattedDate =
                        DateFormat('MMM d, yyyy').format(pickedDate);
                    _dailyStartDate.text = formattedDate;
                  }
                },
                controller: _dailyStartDate,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    filled: true,
                    fillColor: Color.fromARGB(255, 48, 40, 63),
                    labelText: 'Start Date',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 137, 123, 175))),
              ),
              const SizedBox(height: 10),
              Row(children: <Widget>[
                //Repeats
                Expanded(
                    child: DropdownButtonFormField(
                  items: _repeatList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  value: _curRepeat,
                  onChanged: (value) {
                    setState(() {
                      _curRepeat = value.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 48, 40, 63),
                    labelText: 'Repeats',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 137, 123, 175)),
                  ),
                )),
                const SizedBox(width: 10),
                // Every
                Expanded(
                    child: TextFormField(
                  controller: _dailyEvery,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 48, 40, 63),
                      labelText: 'Every',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 137, 123, 175)),
                      suffixText: 'days',
                      suffixStyle: TextStyle(color: Colors.white)),
                ))
              ])
            ])),
      ]),
    );
  }
}

class RadioImage extends StatelessWidget {
  final RadioModel _item;
//
  const RadioImage(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
          width: 80,
          child: Image.asset(
              'assets/icons/difficulty/${_item.isSelected ? _item.iconOff : _item.iconOn}.png'),
          // color: Colors.transparent,
        ),
        const SizedBox(height: 10),
        Text(
          _item.buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: _item.isSelected ? Colors.white : const Color(0xFF6132B4),
          ),
        )
      ],
    );
  }
}

class RadioModel {
  late bool isSelected;
  late final String buttonText;
  late final String? iconOn;
  late final String? iconOff;

  RadioModel(this.isSelected, this.buttonText, this.iconOn, this.iconOff);
}
