import 'package:flutter/material.dart';

import '../RoundedButton.dart';
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
                    btnText: 'Bakıcı Olarak Giriş Yap',
                    onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CaregiverLogin()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    btnText: 'Bakıcı Olarak Hesap Oluştur',
                    onBtnPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const CaregiverRegistration()),
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
