import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Messaging.dart';
import 'PetSitting.dart';

class SearchPage extends StatefulWidget {
  final String token;
  final String userId;
  final String userRole;

  const SearchPage({
    Key? key,
    required this.token,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<PetSitter> petSitters = [];
  String searchCity = "";

  @override
  void initState() {
    super.initState();
    _fetchPetSitters();
  }

  Future<void> _fetchPetSitters() async {
    final String apiUrl = "http://10.0.2.2:5000/api/CaretakerInfo?PageNumber=1&PageSize=100";

    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer ${widget.token}',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> petSittersData = data['data'];

      setState(() {
        petSitters = petSittersData.map((item) => PetSitter.fromJson(item)).toList();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Failed to fetch data. Please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
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
          'Bakıcı Ara',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  searchCity = text;
                });
              },
              decoration: InputDecoration(
                hintText: "Bir şehir ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchCity = "";
                    });
                  },
                ),
              ),
            ),
          ),
         
          Expanded(
            child: ListView.builder(
              itemCount: petSitters.length,
              itemBuilder: (context, index) {
                final petSitter = petSitters[index];

                
                if (searchCity.isNotEmpty && !petSitter.city.toLowerCase().contains(searchCity.toLowerCase())) {
                  return const SizedBox();
                }

                return PetSitterCard(
                  petSitter: petSitter,
                  userId: widget.userId,
                  token: widget.token,
                  userRole: widget.userRole,
                  key: UniqueKey(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PetSitterCard extends StatelessWidget {
  final PetSitter petSitter;
  final String userId;
  final String token;
  final String userRole;

  const PetSitterCard({
    required Key key,
    required this.petSitter,
    required this.userId,
    required this.token,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromARGB(193, 170, 191, 205),
        elevation: 4,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/default_avatar.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${petSitter.firstName} ${petSitter.lastName}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text(
                          petSitter.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          " (${petSitter.reviewCount} yorum)",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${petSitter.hourlyRate} TL/saat",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    petSitter.city,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${petSitter.yearsOfExperience} yıl tecrübe",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    petSitter.skills.join(", "),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
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
                                  // Navigate to the messaging page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Messaging(
                                        petSitter: petSitter,
                                        token: token,
                                        userId: userId,
                                        senderRole: userRole,
                                        receiverRole: "Caretaker",
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
                    icon: const Icon(Icons.message),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
