class RegisterRequestModel {
  String? username;
  String? password;
  String? email;

  RegisterRequestModel({
    this.username,
    this.password,
    this.email,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
