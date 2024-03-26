import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: _isDarkMode ?   ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.grey[900], // Dark mode background color
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: const Color.fromARGB(255, 142, 142, 149), // Light mode background color
            ),
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Profilim',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildProfileInfo(),
              const SizedBox(height: 20),
              _buildDarkModeSwitch(),
              const SizedBox(height: 20),
              _buildProfileOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kiara Josephon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Raigad, Maharashtra',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        _buildProfileItem(Icons.pets, 'Evcil Hayvanım'),
        _buildProfileItem(Icons.shopping_cart, 'Siparişlerim'),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  Widget _buildProfileOptions() {
    return Column(
      children: [
        _buildProfileOption(Icons.settings, 'Ayarlar'),
        _buildProfileOption(Icons.logout, 'Çıkış Yap'),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildDarkModeSwitch() {
    return ListTile(
      leading: const Icon(Icons.nightlight_round),
      title: const Text('Koyu Mod'),
      trailing: Switch(
        value: _isDarkMode,
        onChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}
