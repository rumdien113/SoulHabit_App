import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  String? message;
  Data? data;
  // String? username;
  // String? email;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
    // username = json['username'];
    // email = json['email'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data?.toJson();
    // _data['username'] = username;
    // _data['email'] = email;
    print(_data);
    return _data;
  }
}

class Data {
  Data({
    this.token,
    this.userID,
  });
  String? token;
  String? userID;
  String? username;
  String? email;

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userID = json['userID'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['userID'] = userID;
    _data['username'] = username;
    _data['email'] = email;
    return _data;
  }
}
