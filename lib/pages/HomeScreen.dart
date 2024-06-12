import 'package:flutter/material.dart';
import 'package:petcare/pages/PetSitting.dart';
import 'package:petcare/pages/PetAdoptionPage.dart';

import '../RoundedButton.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  final String userId;
  final String userRole;

  const HomeScreen({
    Key? key,
    required this.token,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/11.png',
              height: 250,
            ),
            const Text(
              'Ne arıyorsunuz?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/7.png',
                    height: 150,
                  ),
                ),
                RoundedButton(
                  btnText: 'Evcil Hayvan Bakıcısı Bul',
                  onBtnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetSitting(
                          token: widget.token,
                          userId: widget.userId,
                          userRole: widget.userRole,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/5.png',
                    height: 150,
                  ),
                ),
                RoundedButton(
                  btnText: 'Bir Evcil Hayvanı Sahiplen',
                  onBtnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PetAdoptionApp(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
