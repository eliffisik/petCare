import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CaregiverFeedScreen.dart';

class CaregiverInfoScreen extends StatefulWidget {
  final String token;
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final bool isCaretaker;

  const CaregiverInfoScreen({
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
  _CaregiverInfoScreenState createState() => _CaregiverInfoScreenState();
}

class _CaregiverInfoScreenState extends State<CaregiverInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _experienceController = TextEditingController();
  final _rateController = TextEditingController();
  final _skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
  }

  Future<void> _submitForm() async {
    final String apiUrl = "http://10.0.2.2:5000/api/CaretakerInfo/Post";

    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> requestBody = {
        "userId": widget.userId,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "city": _cityController.text,
        "yearsOfExperience": int.parse(_experienceController.text),
        "skills": _skillsController.text,
        "hourlyRate": double.parse(_rateController.text),
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
              builder: (context) => CaregiverFeedScreen(
                token: widget.token,
                userId: widget.userId,
                userName: widget.userName,
                firstName: widget.firstName,
                lastName: widget.lastName,
                email: widget.email,
                isCaretaker: widget.isCaretaker,
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
            TextFormField(
              controller: _experienceController,
              decoration: const InputDecoration(
                labelText: "Years of Experience",
                icon: Icon(Icons.timeline),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your years of experience';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _rateController,
              decoration: const InputDecoration(
                labelText: "Hourly Rate (\$)",
                icon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your hourly rate';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _skillsController,
              decoration: const InputDecoration(
                labelText: "Skills",
                icon: Icon(Icons.list),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the skills you offer';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
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
    _experienceController.dispose();
    _rateController.dispose();
    _skillsController.dispose();
    super.dispose();
  }
}
