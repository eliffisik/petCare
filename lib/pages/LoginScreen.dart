import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/pages/PetOwnerInfo.dart';
import 'FeedScreen.dart';
import 'RegisterScreen.dart';

class User {
  final String id;
  final String role;
  
  User({required this.id, required this.role});
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
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
        var data = jsonDecode(response.body);

        var token = data['data']['jwToken'] ?? '';
        var userId = data['data']['id'] ?? '';
        var userName = data['data']['userName'] ?? '';
        var firstName = data['data']['firstName'] ?? '';
        var lastName = data['data']['lastName'] ?? '';
        var email = data['data']['email'] ?? '';
        var isCaretaker = data['data']['isCaretaker'] == false;
        var userRole = isCaretaker ? "Caretaker" : "User";

         if (token.isNotEmpty && userId.isNotEmpty) {
          _checkIfInfoExists(token, userId, userName, firstName, lastName, email, isCaretaker);
        } else {
          print('Login failed: Invalid response data');
        }
      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (error) {
      print('Login error: $error');
    }
  }

  Future<void> _checkIfInfoExists(String token, String userId, String userName, String firstName, String lastName, String email, bool isCaretaker) async {
    final String apiUrl = "http://10.0.2.2:5000/api/PetOwnerInfo/$userId";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['data'] != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FeedScreen(
                token: token,
                userId: userId,
                userName: userName,
                firstName: data['data']['firstName'],
                lastName: data['data']['lastName'],
                email: email,
                isCaretaker: isCaretaker, userRole:isCaretaker ? "Caretaker" : "User",
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetOwnerInfoScreen(
                token: token,
                userId: userId,
                userName: userName,
                firstName: firstName,
                lastName: lastName,
                email: email,
                isCaretaker: isCaretaker,
              ),
            ),
          );
        }
      } else {
        print('Failed to fetch caretaker information: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching caretaker information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  const Color.fromARGB(255, 142, 142, 149),
      backgroundColor: const Color.fromARGB(255, 82, 82, 86),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
  controller: _emailController,
  decoration: InputDecoration(
    labelText: 'Email',
    icon: Icon(Icons.email, color: Color.fromARGB(255, 182, 212, 246)),
    labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246)),
    
    hintStyle: TextStyle(color: Colors.white),
  ),
  keyboardType: TextInputType.emailAddress,
  style: TextStyle(color: Colors.white), 
),
const SizedBox(height: 20),
TextField(
  controller: _passwordController,
  decoration: InputDecoration(
    labelText: 'Şifre',
    icon: Icon(Icons.lock, color: Color.fromARGB(255, 182, 212, 246)),
    labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246)),
    // Adding hintStyle to ensure placeholder text is also styled
    hintStyle: TextStyle(color: Colors.white),
  ),
  obscureText: true,
  style: TextStyle(color: Colors.white), 
),
const SizedBox(height: 20),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  await loginUser(email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(193, 106, 194, 249),
                   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), 
                ),
                child: const Text('Giriş Yap'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: const Text('Hesabınız yok mu? Kayıt olun'),
                 style: TextButton.styleFrom(
    primary: Color.fromARGB(255, 182, 212, 246), 
  ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
