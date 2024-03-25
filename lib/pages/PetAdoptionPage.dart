import 'package:flutter/material.dart';

import '../RoundedButton.dart';

class PetList extends StatefulWidget {
  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  List<Map<String, dynamic>> petAds = [
    {
      'type': 'Köpek',
      'age': '2',
      'gender': 'Erkek',
      'additionalInfo': 'Kısırlaştırılmış, aşıları tam',
      'image': 'assets/dog.jpg', // Örnek bir görsel yolunu temsil ediyor
      'name': 'Max', // Köpeğin ismi
      'location': 'İstanbul', // İlanın konumu
    },
    {
      'type': 'Kedi',
      'age': '1',
      'gender': 'Dişi',
      'additionalInfo': 'Aşıları tam, tüylü',
      'image': 'assets/cat.jpg',
      'name': 'Luna',
      'location': 'Ankara',
    },
    // Buraya istediğiniz kadar ilan ekleyebilirsiniz
  ];

  List<Map<String, dynamic>> filteredPetAds = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredPetAds = petAds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Hayvan türü veya ismi ara...',
                prefixIcon: Icon(Icons.search, color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              
            ),
            onChanged: (value) {
              setState(() {
                filteredPetAds = petAds
                    .where((ad) =>
                        ad['type']
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        ad['name'].toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredPetAds.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color.fromARGB(193, 170, 191, 205),
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(filteredPetAds[index]['image']),
                  ),
                  title: Text(
                      '${filteredPetAds[index]['name']} - ${filteredPetAds[index]['type']}'),
                  subtitle: Text(
                      '${filteredPetAds[index]['age']} yaşında, ${filteredPetAds[index]['gender']}, ${filteredPetAds[index]['location']}'),
                  onTap: () {
                    // İlan detaylarına gitme işlemi
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PetAdoptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PetAdoptionPage(),
    );
  }
}

class PetAdoptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        title: Text('Pet Adoption'),
      ),
      body: PetList(), // PetList widgetini eklemeyi unutma
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ilan oluşturmak için bir sayfaya yönlendirme işlemi
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewAdoptionForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewAdoptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        title: Text('Yeni Sahiplendirme İlanı'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              
              decoration: InputDecoration(labelText: 'Hayvan Türü',labelStyle: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Yaş',labelStyle: TextStyle(color: Colors.white),),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Cinsiyet',labelStyle: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(labelText: 'Ek Bilgiler',labelStyle: TextStyle(color: Colors.white),),
              maxLines: null,
            ),
            SizedBox(height: 20.0),
            Center(
              child: RoundedButton(
                btnText: 'Gönder',
                onBtnPressed: () {
                  // Formu gönderme işlemi
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
