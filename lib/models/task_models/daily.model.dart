class DailyModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? note;
  final String? difficulty;
  final DateTime? startDate;
  final String? repeats;
  final int? every;
  final int? counter;

  DailyModel({
    this.id,
    this.userId,
    this.title,
    this.note,
    this.difficulty,
    this.startDate,
    this.repeats,
    this.every,
    this.counter,
  });

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return DailyModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      difficulty: json['difficulty'] as String?,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      repeats: json['repeats'] as String?,
      every: json['every'] as int?,
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
      'startDate': startDate?.toIso8601String(),
      'repeats': repeats,
      'every': every,
      'counter': counter,
    };
  }

  get daily_id => id;
  get daily_userId => userId;
  get daily_title => title;
  get daily_note => note;
  get daily_difficulty => difficulty;
  get daily_startDate => startDate;
  get daily_repeats => repeats;
  get daily_every => every;
  get daily_counter => counter;

  set daily_id(id) => id = id;
  set daily_userId(userId) => userId = userId;
  set daily_title(title) => title = title;
  set daily_note(note) => note = note;
  set daily_difficulty(difficulty) => difficulty = difficulty;
  set daily_startDate(startDate) => startDate = startDate;
  set daily_repeats(repeats) => repeats = repeats;
  set daily_every(every) => every = every;
  set daily_counter(counter) => counter = counter;

  @override
  String toString() {
    return 'HabitModel{ id: $id, userId: $userId, title: $title, note: $note, difficulty: $difficulty, startDate: $startDate, repeats: $repeats, every: $every, counter: $counter }';
  }
}
