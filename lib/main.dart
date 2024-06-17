import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_habit/pages/home/home.dart';
import 'package:soul_habit/pages/auth/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: pref.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SoulHabit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: (token != null && JwtDecoder.isExpired(token) == false)
            ? const Home(0)
            : const WelcomeScreen());
  }
}
