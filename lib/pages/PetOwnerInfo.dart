import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CaregiverFeedScreen.dart';
import 'FeedScreen.dart';
import 'PetSitting.dart';

class PetOwnerInfoScreen extends StatefulWidget {
  
  final String token;
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final bool isCaretaker;

  const PetOwnerInfoScreen({
    Key? key,
   
    required this.token,
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCaretaker,
  }) : super(key: key);

  @override
  _PetOwnerInfoScreenState createState() => _PetOwnerInfoScreenState();
}

class _PetOwnerInfoScreenState extends State<PetOwnerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _checkIfInfoExists();
  }

  Future<void> _checkIfInfoExists() async {
    final String apiUrl = "http://10.0.2.2:5000/api/PetOwnerInfo/${widget.userId}";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['data'] != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FeedScreen(
                token: widget.token,
                userId: widget.userId,
                userName: widget.userName,
                firstName: data['data']['firstName'],
                lastName: data['data']['lastName'],
                email: widget.email,
                isCaretaker: widget.isCaretaker, userRole: '', 
              ),
            ),
          );
        } else {
          _firstNameController.text = widget.firstName;
          _lastNameController.text = widget.lastName;
        }
      } else {
        _showErrorDialog('Failed to load caretaker information.');
      }
    } catch (error) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  Future<void> _submitForm() async {
    final String apiUrl = "http://10.0.2.2:5000/api/PetOwnerInfo/Post";

    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> requestBody = {
        "userId": widget.userId,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "city": _cityController.text,
       
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${widget.token}",
          },
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedScreen(
                token: widget.token,
                userId: widget.userId,
                userName: widget.userName,
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                isCaretaker: widget.isCaretaker, 
                userRole: 'User',
              ),
            ),
          );
        } else {
          _showErrorDialog('Failed to submit information. Please try again.');
        }
      } catch (error) {
        _showErrorDialog('An error occurred. Please try again.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
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
          'Caregiver Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: "City",
                icon: Icon(Icons.location_city),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
           
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit Information"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
