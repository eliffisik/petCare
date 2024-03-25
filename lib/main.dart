import 'package:flutter/material.dart';
import 'package:petcare/pages/FeedScreen.dart';
import 'package:petcare/pages/HomeScreen.dart';
import 'package:petcare/pages/WelcomeScreen.dart';



void main() async{
WidgetsFlutterBinding.ensureInitialized();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData.light(),
  home:WelcomeScreen(),
  // home:WelcomeScreen(),
  );
    
  }
}