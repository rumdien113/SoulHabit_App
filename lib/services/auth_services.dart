import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soul_habit/models/request/login_request_model.dart';
import 'package:soul_habit/models/request/register_request_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:soul_habit/utils/app_constant.dart';

abstract class AuthServices {
  Future<http.Response> register(RegisterRequestModel body);
  Future<http.Response> login(LoginRequestModel body);
}

class APIServices implements AuthServices {
  static final HttpWithMiddleware _httpClient =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> login(LoginRequestModel body) async {
    const url = AppConstant.login;

    final response = await _httpClient.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(body.toJson()));
    return response;
  }

  @override
  Future<http.Response> register(RegisterRequestModel body) async {
    const url = AppConstant.register;

    final response = await _httpClient.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(body.toJson()));
    return response;
  }
}
