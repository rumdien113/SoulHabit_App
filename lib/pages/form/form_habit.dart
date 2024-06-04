import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soul_habit/models/habit.model.dart';
import 'package:soul_habit/pages/home/habit.dart';
import 'package:soul_habit/pages/home/home.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';
import 'package:soul_habit/services/remote/habit_services.dart';

class FormHabit extends StatefulWidget {
  const FormHabit(this.habit_id, {super.key});

  final String habit_id;
  @override
  State<FormHabit> createState() => _FormHabitState();
}

class _FormHabitState extends State<FormHabit> {
  final TextEditingController _habitTitle = TextEditingController();
  final TextEditingController _habitNotes = TextEditingController();
  final TextEditingController _habitDifficulty = TextEditingController();
  final TextEditingController _habitResetCounter = TextEditingController();
  List<RadioModel> levelList = [];
  List<RadioModel> counterList = [];
  List? items;
  HabitAPI habitServices = HabitAPI();
  // bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    // Difficulty
    levelList.add(RadioModel(true, 'Trivial', 'trivial_off', 'trivial_on'));
    levelList.add(RadioModel(false, 'Easy', 'easy_off', 'easy_on'));
    levelList.add(RadioModel(false, 'Medium', 'medium_off', 'medium_on'));
    levelList.add(RadioModel(false, 'Hard', 'hard_off', 'hard_on'));

    // Counter
    counterList.add(RadioModel(true, 'Daily', '', ''));
    counterList.add(RadioModel(false, 'Weekly', '', ''));
    counterList.add(RadioModel(false, 'Monthly', '', ''));
  }

  void addHabit() async {
    if (_habitTitle.text.isNotEmpty) {
      final body = HabitModel(
          userId: SharedPrefs.UserID,
          title: _habitTitle.text.trim(),
          note: _habitNotes.text.trim(),
          difficulty: _habitDifficulty.text,
          resetCounter: _habitResetCounter.text,
          counter: 0);
      await habitServices.addHabitTask(body).then((response) {
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            _habitTitle.clear();
            _habitNotes.clear();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          }
        } else {
          final data = jsonDecode(response.body);
          final message = data['message'];
          print(message);
        }
      });
    }
  }

  void deleteItem(String id) async {
    await habitServices.deleteHabitTask(id).then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        final data = jsonDecode(response.body);
        final message = data['message'];
        print(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C1C1C),
        appBar: AppBar(
          title:
              const Text('Create Habit', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF6132B4),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            widget.habit_id != ''
                ? TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 25)),
                    onPressed: () {
                      deleteItem(widget.habit_id);
                    },
                    child: const Text('DELETE',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
                : Container(),
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 25)),
              onPressed: () {
                addHabit();
              },
              child: const Text('CREATE',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
                height: 240,
                color: const Color(0xFF6132B4),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _habitTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 67, 67, 67),
                          label: Text(
                            "Habit Title",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _habitNotes,
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
              height: 450,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
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
                    children: levelList
                        .map((e) => InkWell(
                              // focusColor: Colors.transparent,
                              overlayColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.transparent),
                              onTap: () {
                                print(e.buttonText);
                                _habitDifficulty.text = e.buttonText;
                                setState(() {
                                  for (var element in levelList) {
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
                  // Reset Counter
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Reset Counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: counterList
                        .map((e) => InkWell(
                              // focusColor: Colors.transparent,
                              overlayColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.transparent),
                              onTap: () {
                                print(e.buttonText);
                                _habitResetCounter.text = e.buttonText;
                                setState(() {
                                  for (var element in counterList) {
                                    element.isSelected = false;
                                  }
                                  e.isSelected = true;
                                });
                              },
                              child: RadioText(e),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ));
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

class RadioText extends StatelessWidget {
  final RadioModel _item;

  const RadioText(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        color: _item.isSelected
            ? const Color(0xFF6132B4)
            : const Color(0xFFBCA8FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _item.buttonText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _item.isSelected
              ? const Color(0xFFBCA8FF)
              : const Color(0xFF6132B4),
        ),
      ),
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
