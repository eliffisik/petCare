import 'package:flutter/material.dart';
import 'package:petcare/pages/AddingPet.dart';
import 'package:petcare/pages/PostAdd.dart';
import 'package:petcare/pages/ProfilePage.dart';
import 'package:petcare/pages/SearchPage.dart';
import './HomeScreen.dart';


class FeedScreen extends StatefulWidget {
  
  FeedScreen();

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  List<Widget> _screens = [];
  @override
  void initState() {
    super.initState();
_screens = [
      HomeScreen(),
      AddingPet(),
      PostAdd(),
      SearchPage(),
      ProfilePage(),


     
  
    ];
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: '',
          ),
        
           BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        selectedItemColor: Color.fromARGB(193, 101, 181, 231),
        unselectedItemColor: Color.fromARGB(193, 101, 181, 231),
      ),
    );
  }
}
