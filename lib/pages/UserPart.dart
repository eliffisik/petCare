import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/pages/CaregiverMessages.dart';
import 'Messaging.dart';

class User {
  String userId; 
  String firstName;
  String lastName;
  String city;
 


  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'], 
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      city: json['city'] ?? ''
    );
  }
}

class UserPart extends StatefulWidget {
  final String token;
  final String userId;
  final String userRole;

  const UserPart({
    Key? key,
    required this.token,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _UserPartState createState() => _UserPartState();
}

class _UserPartState extends State<UserPart> {
  List<User> users = [];
  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final String apiUrl = "http://10.0.2.2:5000/api/PetOwnerInfo?PageNumber=1&PageSize=100";

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer ${widget.token}',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> petSittersData = data['data'];

        setState(() {
          users = petSittersData.map((item) => User.fromJson(item)).toList();
        });
      } else {
        _showErrorDialog("Failed to fetch data. Please try again.");
      }
    } catch (e) {
      _showErrorDialog("Failed to fetch data. Error: ${e.toString()}");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Evcil Hayvan Sahipleri',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    searchTerm = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Evcil Hayvan Sahibi Ara",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                if (searchTerm.isNotEmpty &&
                    !users[index].firstName
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase())) {
                  return const SizedBox();
                }
                return UserCard(
                  user: users[index],
                  userId: widget.userId,
                  token: widget.token,
                  userRole: widget.userRole,
                  key: UniqueKey(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final String userId;
  final String token;
  final String userRole;

  const UserCard({
    required Key key,
    required this.user,
    required this.userId,
    required this.token,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 300), // Adjust maxWidth as needed
        child: Card(
          color: const Color.fromARGB(193, 170, 191, 205),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/default_avatar.png'),
            ),
            title: Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              user.city,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.message),
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: const Color.fromARGB(193, 104, 183, 232),
                      backgroundColor: const Color.fromARGB(193, 213, 223, 228),
                      title: const Text("Mesaj Gönder"),
                      content: const Text("Bakıcıya mesaj göndermek istediğinize emin misiniz?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CaregiverMessages(
                                        user: user,
                                        token: token,
                                        userId: userId,
                                        senderRole: userRole,
                                        receiverRole: "User",
                                  
                                ),
                              ),
                            );
                          },
                          child: const Text("Evet"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Hayır"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

