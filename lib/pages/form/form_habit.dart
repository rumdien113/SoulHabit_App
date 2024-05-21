import 'package:flutter/material.dart';

class FormHabit extends StatefulWidget {
  const FormHabit({super.key});

  @override
  State<FormHabit> createState() => _FormHabitState();
}

class _FormHabitState extends State<FormHabit> {
  List<RadioModel> levelList = [];
  List<RadioModel> counterList = [];
  bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    // Difficulty
    levelList.add(RadioModel(false, 'Trivial', 'trivial_off', 'trivial_on'));
    levelList.add(RadioModel(false, 'Easy', 'easy_off', 'easy_on'));
    levelList.add(RadioModel(false, 'Medium', 'medium_off', 'medium_on'));
    levelList.add(RadioModel(false, 'Hard', 'hard_off', 'hard_on'));

    // Counter
    counterList.add(RadioModel(false, 'Daily', '', ''));
    counterList.add(RadioModel(false, 'Weekly', '', ''));
    counterList.add(RadioModel(false, 'Monthly', '', ''));
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
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(right: 25)),
              onPressed: () {
                print("Create");
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
                    const TextField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
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
              'assets/icons/${_item.isSelected ? _item.iconOff : _item.iconOn}.png'),
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
