import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/pages/FeedScreen.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   final _emailController = TextEditingController();

     final _passwordController = TextEditingController();
      Future loginUser(  
    String email,  
    String password,
  ) async {
    Uri url = Uri.parse('http://10.0.2.2:5000/api/Account/authenticate');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        print('Login successful!');
         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const FeedScreen()),
                      );
        // Handle successful registration (e.g., navigate to login screen)
      } else {
        print('Login failed: ${response.statusCode}');
        // Handle registration error
      }
    } catch (error) {
      print('Login error: $error');
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
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),

        
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                String password = _passwordController.text;

                await loginUser(email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Login'),
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
    );
  }
}
