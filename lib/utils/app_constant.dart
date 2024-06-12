class AppConstant {
  AppConstant._();
  static const baseAPI = 'http://localhost:3000';

  static const register = '$baseAPI/register';
  static const login = '$baseAPI/login';
  static const add_habit = '$baseAPI/api/habit/store';
  static String get_habit_list(String id) => '$baseAPI/api/habit/getByUserId/$id';
  static String delete_habit(String id) => '$baseAPI/api/habit/deleteById/$id';
  static String update_habit(String id) => '$baseAPI/api/habit/update/$id';
  static String counter(String id, String slug) => '$baseAPI/api/habit/counter/$id/$slug';
}

// const url = 'http://192.168.1.20:3000/';

