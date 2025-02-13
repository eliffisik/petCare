import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import '../RoundedButton.dart';
import 'Caregiver.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromARGB(255, 142, 142, 149),
       backgroundColor: const Color.fromARGB(255, 82, 82, 86),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/11.png',
                    height:350,
                  ),
                ],
              ),
              Column(
                children: [
                  RoundedButton(
                    btnText: 'GİRİŞ YAP',
                    onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>   LoginScreen()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    btnText: 'Hesap Oluştur',
                    onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const RegisterScreen()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    btnText: 'Bakıcı Ol',
                    onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Caregiver()),
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
