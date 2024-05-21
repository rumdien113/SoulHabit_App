import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:soul_habit/NavDrawer.dart';
import 'package:soul_habit/pages/form/form_daily.dart';
import 'package:soul_habit/pages/form/form_habit.dart';
import 'package:soul_habit/pages/form/form_todo.dart';
import 'pages/home/daily.dart';
import 'pages/home/habit.dart';
import 'pages/home/todo.dart';
import 'pages/home/shop.dart';

class Home extends StatefulWidget {
  final token;
  const Home({@required this.token, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String email;
  int currentTab = 0;
  final List<Widget> screens = const [
    Habit(),
    Daily(),
    ToDo(),
    Shop(),
  ];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Habit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Text(email, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (currentTab) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormHabit()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormDaily()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FormTodo()));
              break;
          }
        },
        backgroundColor: const Color.fromARGB(255, 170, 9, 173),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 0),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
        color: const Color(0xFF1C1C1C),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Habit();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Habit',
                      style: TextStyle(
                        color: currentTab == 0 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Daily();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: currentTab == 1 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Daily',
                      style: TextStyle(
                        color: currentTab == 1 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = ToDo();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: currentTab == 2 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'ToDo\'s',
                      style: TextStyle(
                        color: currentTab == 2 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Shop();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: currentTab == 3 ? Colors.blue : Colors.grey,
                    ),
                    Text(
                      'Shop',
                      style: TextStyle(
                        color: currentTab == 3 ? Colors.blue : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
