class DailyModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? note;
  final String? difficulty;
  final DateTime? startDate;
  final String? repeats;
  final int? every;
  final int? counterRepeat;
  final int? counterEvery;
  final int? counterTotal;

  DailyModel({
    this.id,
    this.userId,
    this.title,
    this.note,
    this.difficulty,
    this.startDate,
    this.repeats,
    this.every,
    this.counterRepeat,
    this.counterEvery,
    this.counterTotal,
  });

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return DailyModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      difficulty: json['difficulty'] as String?,
      startDate: json['startDate'] as DateTime?,
      repeats: json['repeats'] as String?,
      every: json['every'] as int?,
      counterRepeat: json['counterRepeat'] as int?,
      counterEvery: json['counterEvery'] as int?,
      counterTotal: json['counterTotal'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'note': note,
      'difficulty': difficulty,
      'startDate': startDate,
      'repeats': repeats,
      'every': every,
      'counterRepeat': counterRepeat,
      'counterEvery': counterEvery,
      'counterTotal': counterTotal,
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
  get daily_counterRepeat => counterRepeat;
  get daily_counterEvery => counterEvery;
  get daily_counterTotal => counterTotal;

  set daily_id(id) => id = id;
  set daily_userId(userId) => userId = userId;
  set daily_title(title) => title = title;
  set daily_note(note) => note = note;
  set daily_difficulty(difficulty) => difficulty = difficulty;
  set daily_startDate(startDate) => startDate = startDate;
  set daily_repeats(repeats) => repeats = repeats;
  set daily_every(every) => every = every;
  set daily_counterRepeat(counterRepeat) => counterRepeat = counterRepeat;
  set daily_counterEvery(counterEvery) => counterEvery = counterEvery;
  set daily_counterTotal(counterTotal) => counterTotal = counterTotal;

  @override
  String toString() {
    return 'HabitModel{ id: $id, userId: $userId, $title, note: $note, difficulty: $difficulty, startDate: $startDate, repeats: $repeats, every: $every, counterRepeat: $counterRepeat, counterEvery: $counterEvery, counterTotal: $counterTotal }';
  }
}
