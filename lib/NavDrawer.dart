import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_habit/pages/auth/welcome_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('rumdien113'),
            accountEmail: Text('rumdien113@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'R',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: BoxDecoration(color: Color(0xFF1C1C1C)),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  }
}
