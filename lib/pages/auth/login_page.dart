import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:soul_habit/models/request/login_request_model.dart';
import 'package:soul_habit/services/remote/auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soul_habit/pages/home/home.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';

import 'welcome_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passToggle = true;
  APIServices authServices = APIServices();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    await SharedPrefs.initialize();
  }

  Future<void> _submitLogin() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final body = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      await authServices.login(body).then((response) async {
        if (response.statusCode == 200) {
          Map<String, dynamic> res = JwtDecoder.decode(response.body);
          Map<String, dynamic> resBody = jsonDecode(response.body);
          final token = resBody['token'];
          final userID = res['_id'];
          final username = res['username'];
          final email = res['email'];
          if (token != null &&
              userID != null &&
              username != null &&
              email != null) {
            await SharedPrefs.setToken(token);
            SharedPrefs.setUserId(userID);
            SharedPrefs.setUsername(username);
            SharedPrefs.setEmail(email);
            // print('Token: ${SharedPrefs.token}');
            // print('User ID: ${SharedPrefs.UserID}');
            // print('Username: ${SharedPrefs.Username}');
            // print('Email: ${SharedPrefs.Email}');
          }

          Fluttertoast.showToast(
            msg: "Login successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home(0)));
        } else {
          final errorResponse = jsonDecode(response.body);
          Fluttertoast.showToast(
            msg: errorResponse['message'] ?? 'Something went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/banner.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildInputFiles(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildInputFiles() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "Sign in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 60),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.check,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Email cannot be empty",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_^ {|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  Fluttertoast.showToast(
                      msg: "Email is not valid",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: passToggle,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  label: const Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Password cannot be empty",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () => print("forgot password"),
            //     child: const Text(
            //       'Forgot Password?',
            //       style: TextStyle(
            //         fontWeight: FontWeight.normal,
            //         fontSize: 17,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _submitLogin(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 70),
                backgroundColor: const Color.fromARGB(170, 179, 179, 179),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "SIGN IN",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            // ElevatedButton.icon(
            //   icon: SizedBox(
            //     width: 20,
            //     height: 20,
            //     child: Image.asset("assets/icons/ic_google.png"),
            //   ),
            //   // ignore: avoid_print
            //   onPressed: () => print("Hello Google"),
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(200, 70),
            //     backgroundColor: const Color.fromARGB(170, 179, 179, 179),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            //   label: const Text(
            //     "Login with Google",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
