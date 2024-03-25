import 'package:flutter/material.dart';

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
class CaregiverLogin extends StatefulWidget {
  const CaregiverLogin({super.key});

  @override
  _CaregiverLoginState createState() => _CaregiverLoginState();
}

class _CaregiverLoginState extends State<CaregiverLogin> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Caregiver Login',
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add caregiver login logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverRegistration()),
                );
              },
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
class CaregiverRegistration extends StatefulWidget {
  const CaregiverRegistration({super.key});

  @override
  _CaregiverRegistrationState createState() => _CaregiverRegistrationState();
}

class _CaregiverRegistrationState extends State<CaregiverRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Caregiver Registration',
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
            // Add caregiver registration UI elements here
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add caregiver registration logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(193, 104, 183, 232),
              ),
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the caregiver login screen
              },
              child: const Text('Already have an account? Login here'),
            ),
          ],
        ),
      ),
    );
  }
}
