import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // ON TAP GO TO LOGIN PAGE
  final void Function()? onTap;

  // Register METHOD
  void register(BuildContext context) {
    // GET AUTH SERVICE
    final auth = AuthService();

    // IF PASSWORDS MATCH -> CREATE USER
    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
            _emailController.text,
            _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(e.toString()),
              ),
        );
      }
    }
    // IF PASSWORDS DON'T MATCH -> TELL USER TO FIX
    else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Passwords don't match!"),
            ),
      );
    }
  }

  RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // LOGO
            Icon(Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary),

            const SizedBox(height: 50),

            // WELCOME BACK MESSAGE
            Text("Let's create an account for you",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16),
            ),

            const SizedBox(height: 25),

            // EMAIL TEXT FIELD
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            // PASSWORD TEXT FIELD
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            // CONFIRM PASSWORD TEXT FIELD
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPwController,
            ),

            const SizedBox(height: 25),

            // LOGIN BUTTON
            MyButton(
                text: 'Register',
                onTap: () => register(context)),

            const SizedBox(height: 25),

            // REGISTER NOW
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                GestureDetector(
                  onTap: onTap,
                  child: Text('Login now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}