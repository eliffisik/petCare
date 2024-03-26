import 'package:flutter/material.dart';

import '../RoundedButton.dart';
import './PetSitting.dart';
import 'PetAdoptionPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
              'What are you looking for?',
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
                  btnText: 'Pet Sitting',
                 onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const PetSitting()),
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
                  btnText: 'Pet Adoption',
                  onBtnPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const PetAdoptionApp()),
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
