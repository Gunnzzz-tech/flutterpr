import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // You can save name and phone number locally, or in Firestore if needed.
      print("User registered: ${userCredential.user?.email}");

      // Navigate to the Home page after successful registration
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      String errorMessage = "An error occurred!";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            errorMessage = "The password is too weak.";
            break;
          case 'email-already-in-use':
            errorMessage = "An account already exists with this email.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          default:
            errorMessage = e.message ?? "An unknown error occurred.";
        }
      }
      print("Registration failed: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
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
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
