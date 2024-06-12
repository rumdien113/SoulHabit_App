class HabitModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? note;
  final String? difficulty;
  final String? resetCounter;
  final int? counter;

  HabitModel({
    this.id,
    this.userId,
    this.title,
    this.note,
    this.difficulty,
    this.resetCounter,
    this.counter,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      difficulty: json['difficulty'] as String?,
      resetCounter: json['resetCounter'] as String?,
      counter: json['counter'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'note': note,
      'difficulty': difficulty,
      'resetCounter': resetCounter,
      'counter': counter,
    };
  }

  get habit_id => id;
  get habit_userId => userId;
  get habit_title => title;
  get habit_note => note;
  get habit_difficulty => difficulty;
  get habit_resetCounter => resetCounter;
  get habit_counter => counter;

  set habit_id(id) => id = id;
  set habit_userId(userId) => userId = userId;
  set habit_title(title) => title = title;
  set habit_note(note) => note = note;
  set habit_difficulty(difficulty) => difficulty = difficulty;
  set habit_resetCounter(resetCounter) => resetCounter = resetCounter;
  set habit_counter(counter) => counter = counter;

  @override
  String toString() {
    return 'HabitModel{ id: $id, userId: $userId, $title, note: $note, difficulty: $difficulty, resetCounter: $resetCounter, counter: $counter }';
  }
}
