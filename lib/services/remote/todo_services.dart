import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../models/task_models/todo.model.dart';
import '../../utils/app_constant.dart';

abstract class TodoServices {
  Future<http.Response> getTodoList(String userID);
  Future<http.Response> addTodoTask(TodoModel body);
  Future<http.Response> deleteTodoTask(String taskID);
  Future<http.Response> updateTodoTask(TodoModel body, String id);
}

class TodoAPI implements TodoServices {
  static final _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);
  @override
  Future<http.Response> addTodoTask(TodoModel body) async {
    return await _httpClient.post(Uri.parse(AppConstant.add_todo),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(body.toJson()));
  }

  @override
  Future<http.Response> deleteTodoTask(String taskID) async {
    final response = await _httpClient.delete(
      Uri.parse(AppConstant.delete_todo_task(taskID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }
 
  @override
  Future<http.Response> getTodoList(String userID) async {
    return await _httpClient.get(
      Uri.parse(AppConstant.get_todo_list(userID)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
  }

  @override
  Future<http.Response> updateTodoTask(TodoModel body, String id) async {
    final response = await _httpClient.put(
      Uri.parse(AppConstant.update_todo_task(id)),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }
}
