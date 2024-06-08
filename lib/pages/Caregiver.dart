import 'package:flutter/material.dart';

import 'CaregiverLogin.dart';
import 'CaregiverRegistration.dart';

class Caregiver extends StatefulWidget {
  const Caregiver({super.key});

  @override
  _CaregiverState createState() => _CaregiverState();
}

class _CaregiverState extends State<Caregiver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 142, 142, 149),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Caregiver',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverLogin()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Login as Caregiver'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverRegistration()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Register as Caregiver'),
            ),
          ],
        ),
      ),
    );
  }
}
