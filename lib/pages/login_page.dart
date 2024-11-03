import 'package:chatapp/components/my_button.dart';
import 'package:flutter/material.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {

  // EMAIL & PASSWORD CONTROLLER
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // ON TAP GO TO REGISTER PAGE
  final void Function()? onTap;

  // LOGIN METHOD
  Future<void> login(BuildContext context) async {
    // AUTH SERVICE
    final authService = AuthService();

    // TRY LOGIN
    try {
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }

    // CATCH ANY ERRORS
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  LoginPage({
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
            Text(' Welcome back, you have been missed! ',
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

            const SizedBox(height: 25),

          // LOGIN BUTTON
            MyButton(
                text: 'Login',
                onTap: () => login(context),
            ),

            const SizedBox(height: 25),

          // REGISTER NOW
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member? ',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                GestureDetector(
                  onTap: onTap,
                  child: Text('Register now',
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
