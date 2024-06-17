import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soul_habit/models/task_models/todo.model.dart';
import 'package:soul_habit/services/remote/todo_services.dart';

import '../../services/local/shared_prefs.dart';
import '../home/home.dart';

class FormTodo extends StatefulWidget {
  const FormTodo(this.task, {super.key});

  final TodoModel? task;
  @override
  State<FormTodo> createState() => _FormTodoState();
}

class _FormTodoState extends State<FormTodo> {
  //controller
  late final TextEditingController _todoTitle =
      TextEditingController(text: widget.task?.todo_title);
  late final TextEditingController _todoNotes =
      TextEditingController(text: widget.task?.todo_note);
  late final TextEditingController _todoDifficulty = TextEditingController();
  late final TextEditingController _todoDueDate = TextEditingController(
      text: widget.task?.todo_duetDate != null
          ? DateFormat('MMM d, yyyy').format(widget.task!.todo_duetDate)
          : DateFormat('MMM d, yyyy').format(DateTime.now()));
  //array
  final List<RadioModel> _levelList = [];

  //api
  TodoAPI todoService = TodoAPI();

  @override
  void initState() {
    super.initState();

    // Difficulty
    _levelList.add(RadioModel(false, 'Trivial', 'trivial_off', 'trivial_on'));
    _levelList.add(RadioModel(false, 'Easy', 'easy_off', 'easy_on'));
    _levelList.add(RadioModel(false, 'Medium', 'medium_off', 'medium_on'));
    _levelList.add(RadioModel(false, 'Hard', 'hard_off', 'hard_on'));
    for (var i in _levelList) {
      if (i.buttonText == widget.task?.todo_difficulty) {
        i.isSelected = true;
        _todoDifficulty.text = i.buttonText;
      }
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      setState(() {
        _todoDueDate.text = DateFormat('MMM d, yyyy').format(picked);
      });
    }
  }

  void addTask() async {
    if (_todoTitle.text.isNotEmpty) {
      final DateTime parsedDate =
          DateFormat("MMM dd, yyyy").parse(_todoDueDate.text);

      final DateTime utcDate =
          DateTime.utc(parsedDate.year, parsedDate.month, parsedDate.day);

      final body = TodoModel(
        userId: SharedPrefs.UserID,
        title: _todoTitle.text.trim(),
        note: _todoNotes.text.trim(),
        difficulty: _todoDifficulty.text,
        duetDate: utcDate,
      );
      print("Request Body: ${body.toJson()}");

      try {
        final response = await todoService.addTodoTask(body);
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Home(2)));
          } else {
            print("Server responded with an error: ${jsonResponse['message']}");
          }
        } else {
          final data = jsonDecode(response.body);
          final message = data['message'];
          print("Error Message: $message");
        }
      } catch (e) {
        print("An error occurred: $e");
      }
    } else {
      print("Title is empty. Cannot add task.");
    }
  }

  void updateItem() async {
    if (_todoTitle.text.isNotEmpty) {
      final DateTime parsedDate =
          DateFormat("MMM dd, yyyy").parse(_todoDueDate.text);
      final DateTime utcDate =
          DateTime.utc(parsedDate.year, parsedDate.month, parsedDate.day);

      final body = TodoModel(
        id: widget.task?.todo_id,
        userId: SharedPrefs.UserID,
        title: _todoTitle.text.trim(),
        note: _todoNotes.text.trim(),
        difficulty: _todoDifficulty.text,
        duetDate: utcDate,
      );
      print("Request Body: ${body.toJson()}");
      await todoService
          .updateTodoTask(body, widget.task?.todo_id)
          .then((response) {
        if (response.statusCode == 200) {
          jsonDecode(response.body);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home(2)));
        } else {
          final data = jsonDecode(response.body);
          final message = data['message'];
          print(message);
        }
      });
    }
  }

  void deleteItem(String id) async {
    await todoService.deleteTodoTask(id).then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home(2)));
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
            title: widget.task == null
                ? const Text('Create Todo',
                    style: TextStyle(color: Colors.white))
                : const Text('Update Todo',
                    style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF6132B4),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: widget.task != null
                ? <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(right: 25)),
                      onPressed: () {
                        // print("Delete");
                        deleteItem(widget.task?.todo_id);
                      },
                      child: const Text('DELETE',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(right: 25)),
                      onPressed: () {
                        // print("Update");
                        updateItem();
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
                        // print("Create");
                        addTask();
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
                    controller: _todoTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 67, 67, 67),
                        label: Text(
                          "Todo Title",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _todoNotes,
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
                              _todoDifficulty.text = e.buttonText;
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
                // Due Date
                TextField(
                  onTap: () {
                    _selectDate();
                  },
                  controller: _todoDueDate,
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      filled: true,
                      fillColor: Color.fromARGB(255, 48, 40, 63),
                      labelText: 'Due Date',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 137, 123, 175))),
                ),
              ])),
        ]));
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
