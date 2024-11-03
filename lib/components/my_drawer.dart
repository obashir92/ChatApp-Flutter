import 'package:flutter/material.dart';

import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // GET AUTH SERVICE
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            // LOGO
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
            ),

            // HOME LIST TILE
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text('H O M E'),
                leading: Icon(Icons.home),
                onTap: (){
                  // POP THE DRAWER
                  Navigator.pop(context);
                },
              ),
            ),

            // SETTINGS LIST TILE
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                title: Text('S E T T I N G S'),
                leading: Icon(Icons.settings),
                onTap: (){
                  // POP THE DRAWER
                  Navigator.pop(context);
                  // NAVIGATE TO SETTINGS PAGE
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
          ),

          // LOG OUT LIST TILE
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}