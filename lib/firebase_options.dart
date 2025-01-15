import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';


const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyCSjILo5NmPNoPnIZvrpVkt28lV9I3w5q4",
  appId: "1:1078848904627:android:0c3bfd5fde51c5ea8b7fc6",
  messagingSenderId: "1078848904627",
  projectId: "fire-setup-cb475",
);

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User registered');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
