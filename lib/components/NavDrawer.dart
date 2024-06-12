import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_habit/pages/auth/welcome_screen.dart';
import 'package:soul_habit/services/local/shared_prefs.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(SharedPrefs.Username ?? 'username'),
            accountEmail: Text(SharedPrefs.Email ?? 'email'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'R',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            decoration: const BoxDecoration(color: Color(0xFF1C1C1C)),
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
