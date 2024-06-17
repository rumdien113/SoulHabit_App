class TodoModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? note;
  final String? difficulty;
  final DateTime? duetDate;

  TodoModel({
    this.id,
    this.userId,
    this.title,
    this.note,
    this.difficulty,
    this.duetDate,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      difficulty: json['difficulty'] as String?,
      duetDate: json['duetDate'] != null ? DateTime.parse(json['duetDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'note': note,
      'difficulty': difficulty,
      'duetDate': duetDate?.toIso8601String(),
    };
  }

  get todo_id => id;
  get todo_userId => userId;
  get todo_title => title;
  get todo_note => note;
  get todo_difficulty => difficulty;
  get todo_duetDate => duetDate;

  set todo_id(id) => id = id;
  set todo_userId(userId) => userId = userId;
  set todo_title(title) => title = title;
  set todo_note(note) => note = note;
  set todo_difficulty(difficulty) => difficulty = difficulty;
  set todo_duetDate(duetDate) => duetDate = duetDate;

  @override
  String toString() {
    return 'HabitModel{ id: $id, userId: $userId, title: $title, note: $note, difficulty: $difficulty, duetDate: $duetDate }';
  }
}
