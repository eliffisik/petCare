import 'package:flutter/material.dart';
import 'package:petcare/pages/FeedScreen.dart';
import 'package:petcare/pages/WelcomeScreen.dart';



void main() async{
WidgetsFlutterBinding.ensureInitialized();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData.light(),
  home:const WelcomeScreen(),
 
  );
    
  }
}