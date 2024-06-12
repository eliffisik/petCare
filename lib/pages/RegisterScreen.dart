import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/pages/LoginScreen.dart';
import 'FeedScreen.dart';

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
  bool _isCaretaker = false;

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
        var data = jsonDecode(responseBody);
        var userId = data['data'];  

        print('Registration successful!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedScreen(
              token: '',  
              userId: userId,
              userName: userName,
              firstName: firstName,
              lastName: lastName,
              email: email,
              isCaretaker: isCaretaker,
              userRole: isCaretaker ? "Caretaker" : "User",
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
   backgroundColor: const Color.fromARGB(255, 82, 82, 86),
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
                  labelText: 'İsim',
                  icon: Icon(Icons.person,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Soyisim',
                  icon: Icon(Icons.person,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  icon: Icon(Icons.person,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  icon: Icon(Icons.lock,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Şifreyi Onayla',
                  icon: Icon(Icons.lock,color: Color.fromARGB(255, 182, 212, 246),),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 182, 212, 246),),
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
                  backgroundColor: Color.fromARGB(193, 106, 194, 249),
                   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), 
                ),
                child: const Text('Kayıt Ol'),
              ),
          
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                child: const Text('Zaten hesabınız var mı? Buradan giriş yapın'),
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
