import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';  // Import the RegisterPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      String errorMessage = "An error occurred!";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password.";
            break;
          default:
            errorMessage = e.message ?? "An unknown error occurred.";
        }
      }
      print("Login failed: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to RegisterPage when Register button is pressed
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
