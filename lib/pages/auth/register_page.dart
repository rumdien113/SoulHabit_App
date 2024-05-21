import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soul_habit/config.dart';
import 'package:http/http.dart' as http;

import 'welcome_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  bool passToggle = true;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      } else {
        print("something went wrong");
      }
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            _buildInputFiles(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFiles() {
    return ClipPath(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "Sign up",
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
                bool passwordValid = RegExp(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%.,#^*?&])[A-Za-z\d@$!%.,#^*?&]{6,}$")
                    .hasMatch(value);
                if (!passwordValid) {
                  Fluttertoast.showToast(
                      msg: "Password is not valid",
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
                    "Password Confirmation",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => {
                if (passwordController.text !=
                    passwordConfirmationController.text)
                  {
                    Fluttertoast.showToast(
                        msg: "Password and Password Confirmation do not match",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
                else
                  registerUser()
              },
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
            ElevatedButton.icon(
              icon: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset("assets/icons/ic_google.png"),
              ),
              onPressed: () => print("Hello Google"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 70),
                backgroundColor: const Color.fromARGB(170, 179, 179, 179),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              label: const Text(
                "Login with Google",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
