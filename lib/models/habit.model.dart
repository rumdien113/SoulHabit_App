class HabitModel {
  String _id = '';
  String _title = '';
  String _note = '';
  String _difficulty = '';
  String _resetCounter = '';
  int _counter = 0;

  Habit({
    String? id,
    required String title,
    required String note,
    required String difficulty,
    required String resetCounter,
    required int counter,
  }) {
    if (id != null) _id = id;
    _title = title;
    _note = note;
    _difficulty = difficulty;
    _resetCounter = resetCounter;
    _counter = counter;
  }

  get id => _id;
  get title => _title;
  get note => _note;
  get difficulty => _difficulty;
  get resetCounter => _resetCounter;
  get counter => _counter;

  set id(id) => _id = id;
  set title(title) => _title = title;
  set note(note) => _note = note;
  set difficulty(difficulty) => _difficulty = difficulty;
  set resetCounter(resetCounter) => _resetCounter = resetCounter;
  set counter(counter) => _counter = counter;

  @override
  String toString() {
    return 'Habit{_id: $_id \n _title: $_title \n _note: $_note \n _difficulty: $_difficulty \n _resetCounter: $_resetCounter \n _counter: $_counter}';
  }
}
