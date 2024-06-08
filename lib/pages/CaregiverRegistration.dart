import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'CaregiverFeedScreen.dart';

class CaregiverRegistration extends StatefulWidget {
  const CaregiverRegistration({super.key});

  @override
  _CaregiverRegistrationState createState() => _CaregiverRegistrationState();
}

class _CaregiverRegistrationState extends State<CaregiverRegistration> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isCaretaker = true;  

  Future<void> registerUser(
    String firstName,
    String lastName,
    String email,
    String userName,
    String password,
    String confirmPassword,
    bool isCaretaker,
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
          "isCaretaker": isCaretaker,  
        }),
      );


      if (response.statusCode == 200) {
         var responseBody = response.body;
        print('Response body: $responseBody');
          var data = jsonDecode(responseBody);
       var userId = data['data'];  

      
        
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CaregiverFeedScreen(
                token: '',
                userId: userId,
                userName: userName,
                firstName: firstName,
                lastName: lastName,
                email: email,
                isCaretaker: isCaretaker,
              ),
            ),
          );
      } else {
        print('Registration failed: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Registration error: $error');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 142, 142, 149),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  await registerUser(
                    _firstNameController.text,
                    _lastNameController.text,
                    _emailController.text,
                    _userNameController.text,
                    _passwordController.text,
                    _confirmPasswordController.text,
                    _isCaretaker,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(193, 104, 183, 232),
                ),
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Login here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
