import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:soul_habit/models/task_models/habit.model.dart';
import 'package:soul_habit/utils/app_constant.dart';

abstract class HabitServices {
  Future<http.Response> getHabitList(String userID);
  Future<http.Response> addHabitTask(HabitModel body);
  Future<http.Response> deleteHabitTask(String taskID);
  Future<http.Response> updateHabitTask(HabitModel body, String id);
  Future<http.Response> counter(String taskId, String slug);
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
      Uri.parse(AppConstant.get_habit_list(userID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
  }

  @override
  Future<http.Response> addHabitTask(HabitModel body) async {
    final response = await _httpClient.post(
      Uri.parse(AppConstant.add_habit),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> deleteHabitTask(String taskID) async {
    final response = await _httpClient.delete(
      Uri.parse(AppConstant.delete_habit(taskID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
    return response;
  }

  @override
  Future<http.Response> updateHabitTask(HabitModel body, String id) async {
    final response = await _httpClient.put(
        Uri.parse(AppConstant.update_habit(id)),
        headers: {
          'content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(body.toJson()));
    return response;
  }

  @override
  Future<http.Response> counter(String id, String slug) async {
    final response = await _httpClient
        .put(Uri.parse(AppConstant.counter(id, slug)), headers: {
      'content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    });
    return response;
  }
}
