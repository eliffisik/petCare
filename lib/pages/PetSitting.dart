import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Messaging.dart';

class PetSitting extends StatefulWidget {
  const PetSitting({super.key});

  @override
  _PetSittingState createState() => _PetSittingState();
}

class _PetSittingState extends State<PetSitting> {
  List<PetSitter> petSitters = [];
  String aramaTerimi = "";

  @override
  void initState() {
    super.initState();
    _fetchPetSitters();
  }

  Future<void> _fetchPetSitters() async {
    final String apiUrl = "http://10.0.2.2:5000/api/CaretakerInfo?PageNumber=1&PageSize=100"; 

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> petSittersData = data['data']; 

      setState(() {
        petSitters = petSittersData.map((item) => PetSitter.fromJson(item)).toList();
      });
    } else {
      // Handle error
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
          'Evcil Hayvan Bakıcısı',
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
                    aramaTerimi = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Bakıcı Ara",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            // Bakıcı listesi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: petSitters.length,
              itemBuilder: (context, index) {
                // Arama filtresine göre bakıcıları filtreleme
                if (aramaTerimi.isNotEmpty &&
                    !petSitters[index].firstName
                        .toLowerCase()
                        .contains(aramaTerimi.toLowerCase())) {
                  return const SizedBox();
                }
                return PetSitterCard(petSitter: petSitters[index], key: UniqueKey(),);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetSitter {
  String firstName;
  String lastName;
  double rating;
  int reviewCount;
  double hourlyRate;
  String city;
  int yearsOfExperience;
  List<String> skills;

  PetSitter({
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRate,
    required this.city,
    required this.yearsOfExperience,
    required this.skills,
  });

  factory PetSitter.fromJson(Map<String, dynamic> json) {
    return PetSitter(
      firstName: json['firstName'],
      lastName: json['lastName'],
      rating: json['rating'] ?? 4.5,
      reviewCount: json['reviewCount'] ?? 0,
      hourlyRate: json['hourlyRate'].toDouble(),
      city: json['city'],
      yearsOfExperience: json['yearsOfExperience'],
      skills: List<String>.from(json['skills'].split(',')),
    );
  }
}


class PetSitterCard extends StatelessWidget {
  final PetSitter petSitter;

  const PetSitterCard({required Key key, required this.petSitter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromARGB(193, 170, 191, 205),
        elevation: 4,
        child: Column(
          children: [
            // Bakıcı resmi ve bilgileri
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
            // Bakıcı detayları
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
                                
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Messaging(petSitter: petSitter),
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
