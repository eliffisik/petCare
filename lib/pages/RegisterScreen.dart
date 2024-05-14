import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/pages/FeedScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future registerUser(
    String firstName,
    String lastName,
    String email,
    String userName,
    String password,
    String confirmPassword,
  ) async {
    Uri url = Uri.parse('http://10.0.2.2:5000/api/Account/register');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "userName": userName,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        print('Registration successful!');
         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const FeedScreen()),
                      );
        // Handle successful registration (e.g., navigate to login screen)
      } else {
        print('Registration failed: ${response.statusCode}');
        // Handle registration error
      }
    } catch (error) {
      print('Registration error: $error');
      // Handle network or other errors
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 142, 142, 149),
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(193, 104, 183, 232),
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'Register',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String userName = _userNameController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                await registerUser(firstName, lastName, email, userName, password, confirmPassword);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the login screen
              },
              child: const Text('Already have an account? Login here'),
            ),
          ],
        ),
      ),
    ),
  );
}

}
