class AppConstant {
  AppConstant._();
  static const baseAPI = 'http://localhost:3000';

  // Auth
  static const register = '$baseAPI/register';
  static const login = '$baseAPI/login';

  // Habit
  static const add_habit = '$baseAPI/api/habit/store';
  static String get_habit_list(String id) => '$baseAPI/api/habit/getByUserId/$id';
  static String delete_habit(String id) => '$baseAPI/api/habit/deleteById/$id';
  static String update_habit(String id) => '$baseAPI/api/habit/update/$id';
  static String counter(String id, String slug) => '$baseAPI/api/habit/counter/$id/$slug';

  // Daily
  static const add_daily = '$baseAPI/api/daily/store';
  static String get_daily_list(String id) => '$baseAPI/api/daily/getByUserId/$id';
}

// const url = 'http://192.168.1.20:3000/';

