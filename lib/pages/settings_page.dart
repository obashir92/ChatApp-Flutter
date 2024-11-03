import 'package:chatapp/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text('Settings'),
        centerTitle: true,
      ),

      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // DARK MODE
            Text('Dark Mode'),

            // SWITCH TOGGLE
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()),
          ],),
      ),
    );
  }
}