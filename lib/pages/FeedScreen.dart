import 'package:flutter/material.dart';
import 'package:petcare/pages/AddingPet.dart';
import 'package:petcare/pages/PostAdd.dart';
import 'package:petcare/pages/ProfilePage.dart';
import 'package:petcare/pages/SearchPage.dart';
import './HomeScreen.dart';


class FeedScreen extends StatefulWidget {
  
  const FeedScreen({super.key});

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
      const HomeScreen(),
      const AddingPet(),
      const PostAdd(),
      const SearchPage(),
      const ProfilePage(),


     
  
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
        items: const [
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
        selectedItemColor: const Color.fromARGB(193, 101, 181, 231),
        unselectedItemColor: const Color.fromARGB(193, 101, 181, 231),
      ),
    );
  }
}
