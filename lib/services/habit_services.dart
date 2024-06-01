import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:soul_habit/utils/app_constant.dart';

abstract class HabitServices {
  Future<http.Response> getHabitList(String userID);
}

class HabitAPI implements HabitServices {
  static final _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<http.Response> getHabitList(String userID) async {
    return await _httpClient.get(
      Uri.parse(AppConstant.get_habit_list + userID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
  }
}
