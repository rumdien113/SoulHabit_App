import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;
  static const String accessToken = 'accessToken';
  static const String userId = '_id';
  static const String username = 'username';
  static const String email = 'email';
  // static const String avatarImagePathKey = 'avatarImagePath';

  //print token, _id, username
  static void printAll() {
    print('Token: ${token}');
    print('User ID: ${UserID}');
    print('Username: ${Username}');
    print('Email: ${email}');
  }

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    final encryptedToken = encrypt(token);
    await _prefs.setString(accessToken, encryptedToken);
  }

  static String? get token {
    String? encryptedToken = _prefs.getString(accessToken);
    return encryptedToken != null ? decrypt(encryptedToken) : null;
  }

  static set token(String? token) {
    String? encryptedToken = token != null ? encrypt(token) : null;
    _prefs.setString(accessToken, encryptedToken ?? '');
  }

  static void setUserId(String id) {
    _prefs.setString(userId, id);
  }

  static String? get UserID {
    return _prefs.getString(userId);
  }

  static void setUsername(String name) {
    _prefs.setString(username, name);
  }

  static String? get Username {
    return _prefs.getString(username);
  }

  static void setEmail(String e) {
    _prefs.setString(email, e);
  }

  static String? get Email {
    return _prefs.getString(email);
  }

  static bool get isLogin => token?.isNotEmpty ?? false;

  static void removeSeason() {
    print('Removing user session token: $token');
    print('Removing user session user_id: $UserID');
    print('Removing user session email: $email');
    print('Removing user session username: $username');
    // print('Removing user session avatar: $avatarImagePath');
    _prefs.remove(accessToken);
    _prefs.remove(userId);
    _prefs.remove(email);
    _prefs.remove(username);
    // _prefs.remove(avatarImagePathKey);
    print('User session token and user_id removed successfully.');
  }

  static String encrypt(String data) {
    // Implement actual encryption logic here
    return data;
  }

  static String decrypt(String encryptedData) {
    // Implement actual decryption logic here
    return encryptedData;
  }

  // // Thêm hàm setAvatarImagePath để lưu đường dẫn ảnh vào SharedPreferences
  // static Future<void> setAvatarImagePath(String imagePath) async {
  //   await _prefs.setString(avatarImagePathKey, imagePath);
  // }

  // // Thêm hàm avatarImagePath để lấy đường dẫn ảnh từ SharedPreferences
  // static String? get avatarImagePath {
  //   return _prefs.getString(avatarImagePathKey);
  // }

  // static Future<void> setAvatarImagePath(int user_id, String imagePath) async {
  //   await _prefs.setString('$avatarImagePathKey$user_id', imagePath);
  // }

  // static String? getAvatarImagePath(int user_id) {
  //   return _prefs.getString('$avatarImagePathKey$user_id');
  // }
}
