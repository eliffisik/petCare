import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'WelcomeScreen.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final bool isCaretaker;

  const ProfilePage({
    Key? key,
    required this.userId,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCaretaker,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;

  Future<List<Map<String, dynamic>>> fetchPets() async {
    var url = Uri.parse('http://10.0.2.2:5000/api/Pet/${widget.userId}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response from server: $jsonResponse'); // Debug line
      if (jsonResponse is Map && jsonResponse.containsKey('data')) {
        var petData = jsonResponse['data'];
        if (petData is List) {
          return List<Map<String, dynamic>>.from(petData);
        } else if (petData is Map) {
          return [Map<String, dynamic>.from(petData)];
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load pets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.grey[900], // Dark mode background color
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Color.fromARGB(255, 217, 217, 223), // Light mode background color
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/pp.png'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.firstName} ${widget.lastName}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        _buildProfileItem(Icons.pets, 'Evcil Hayvanım', onTap: () async {
          try {
            var pets = await fetchPets();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PetsPage(pets: pets),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load pets: $e')),
            );
          }
        }),
        _buildProfileItem(Icons.shopping_cart, 'Siparişlerim'),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildProfileOptions() {
     return Column(
    children: [
      _buildProfileOption(Icons.settings, 'Ayarlar'),
      _buildProfileOption(Icons.logout, 'Çıkış Yap', onTap: () {
      
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()), 
          (Route<dynamic> route) => false,
        );
      }),
    ],
  );
}

  Widget _buildProfileOption(IconData icon, String title ,{VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
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

class PetsPage extends StatelessWidget {
  final List<Map<String, dynamic>> pets;

  const PetsPage({Key? key, required this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Pets", style: TextStyle(fontSize: 24)), 
        backgroundColor: Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[850], 
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          var pet = pets[index];
          Uint8List imageBytes;
          try {
            imageBytes = base64Decode(pet['imagePath']);
          } catch (e) {
            imageBytes = Uint8List(0);  
          }
          return Card( 
            color: const Color.fromARGB(255, 89, 89, 89), 
            margin: EdgeInsets.all(12), 
            child: ListTile(
              contentPadding: EdgeInsets.all(16), 
              leading: CircleAvatar(
                radius: 40, 
                backgroundImage: MemoryImage(imageBytes),
              ),
              title: Text(
                pet['name'],
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), 
              ),
              subtitle: Text(
                '${pet['breed']} ', 
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20), 
              ),
            ),
          );
        },
      ),
    );
  }
}