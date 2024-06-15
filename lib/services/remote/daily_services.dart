import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:soul_habit/utils/app_constant.dart';
import '../../models/task_models/daily.model.dart';

abstract class DailyServices {
  Future<http.Response> getDailyList(String userID);
  Future<http.Response> addDailyTask(DailyModel body);
  Future<http.Response> deleteDailyTask(String taskID);
  Future<http.Response> updateDailyTask(DailyModel body, String id);
  Future<http.Response> counter(String taskId, String slug);
  Future<http.Response> updateDailyState(String id, String state);
}

class DailyAPI implements DailyServices {
  static final _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<http.Response> getDailyList(String userID) async {
    return await _httpClient.get(
      Uri.parse(AppConstant.get_daily_list(userID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
  }

  @override
  Future<http.Response> addDailyTask(DailyModel body) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(AppConstant.add_daily),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(body.toJson()),
      );
      return response;
    } catch (e) {
      print("Failed to send request: $e");
      rethrow; // Re-throwing the exception after logging
    }
  }

  @override
  Future<http.Response> updateDailyTask(DailyModel body, String id) async {
    final response = await _httpClient.put(
      Uri.parse(AppConstant.update_daily(id)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> deleteDailyTask(String taskID) async {
    final response = await _httpClient.delete(
      Uri.parse(AppConstant.delete_daily(taskID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  @override
  Future<http.Response> counter(String taskId, String slug) async {
    final response = await _httpClient
        .put(Uri.parse(AppConstant.counter(taskId, slug, 'daily')), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    return response;
  }
  
  @override
  Future<http.Response> updateDailyState(String id, String state) async {
    final response = await _httpClient.put(
      Uri.parse(AppConstant.update_daily_state(id, state)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
