import 'package:flutter/material.dart';
import 'package:petcare/pages/AddingPet.dart';
import 'package:petcare/pages/PostAdd.dart';
import 'package:petcare/pages/ProfilePage.dart';
import 'package:petcare/pages/SearchPage.dart';
import './HomeScreen.dart';

class FeedScreen extends StatefulWidget {
  final String token;
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final bool isCaretaker;
  final String userRole;

  const FeedScreen({
    Key? key,
    required this.token,
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCaretaker,
    required this.userRole,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        token: widget.token,
        userId: widget.userId,
        userRole: widget.userRole,
      ),
      AddingPet(),
      SearchPage(
        token: widget.token,
        userId: widget.userId,
        userRole: widget.userRole,
      ),
      ProfilePage(
        userId: widget.userId,
        userName: widget.userName,
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        isCaretaker: widget.isCaretaker,
      ),
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
