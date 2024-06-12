import 'package:flutter/material.dart';
import 'package:petcare/pages/UserPart.dart';

import '../RoundedButton.dart';
import './PetSitting.dart';
import 'PetAdoptionPage.dart';

class CaregiverHomeScreen extends StatefulWidget {
    final String token;
  final String userId;
 final String userRole;
  const CaregiverHomeScreen({
    Key? key,
    required this.token,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _CaregiverHomeScreenState createState() => _CaregiverHomeScreenState();
}

class _CaregiverHomeScreenState extends State<CaregiverHomeScreen> {
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
                  btnText: 'Evcil Hayvan Sahipleri',
                  onBtnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPart(
                          token: widget.token,
                          userId: widget.userId, userRole:widget.userRole,
                        
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
