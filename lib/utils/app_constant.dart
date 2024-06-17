class AppConstant {
  AppConstant._();
  static const baseAPI = 'http://localhost:3000';

  // Auth
  static const register = '$baseAPI/register';
  static const login = '$baseAPI/login';

  // Habit
  static const add_habit = '$baseAPI/api/habit/store';
  static String get_habit_list(String id) =>
      '$baseAPI/api/habit/getByUserId/$id';
  static String delete_habit(String id) => '$baseAPI/api/habit/deleteById/$id';
  static String update_habit(String id) => '$baseAPI/api/habit/update/$id';

  // Daily
  // chưa có API reset cho daily
  static const add_daily = '$baseAPI/api/daily/store';
  static String get_daily_list(String id) =>
      '$baseAPI/api/daily/getByUserId/$id';
  static String delete_daily(String id) => '$baseAPI/api/daily/deleteById/$id';
  static String update_daily(String id) => '$baseAPI/api/daily/update/$id';
  static String update_daily_state(String id, String state) =>
      '$baseAPI/api/daily/state/$id/$state';

  // Todo
  static const add_todo = '$baseAPI/api/todo/store';
  static String get_todo_list(String id) => '$baseAPI/api/todo/getByUserId/$id';
  static String delete_todo_task(String id) => '$baseAPI/api/todo/delete/$id';
  static String update_todo_task(String id) => '$baseAPI/api/todo/update/$id';
  static String get_task_by_id(String id) => '$baseAPI/api/todo/getById/$id';

  // Counter
  static String counter(String id, String slug, String typeAPI) =>
      '$baseAPI/api/$typeAPI/counter/$id/$slug';
}

// const url = 'http://192.168.1.20:3000/';

