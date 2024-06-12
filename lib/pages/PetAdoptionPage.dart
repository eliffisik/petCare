import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';


class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption',
      theme: ThemeData(
        brightness: Brightness.dark, 
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white), 
          headline6: TextStyle(color: Colors.white), 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.white, 
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      home: const PetAdoptionPage(),
    );
  }
}

class PetAdoptionPage extends StatelessWidget {
  const PetAdoptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Evcil Hayvan Sahiplendirme İlanları',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const PetList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewAdoptionForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PetList extends StatefulWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  List<Map<String, dynamic>> petAds = [];

  @override
  void initState() {
    super.initState();
    _fetchPetAds();
  }

  Future<void> _fetchPetAds() async {
    const url = 'http://10.0.2.2:5000/api/PetAdoption?PageNumber=1&PageSize=100';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> pets = jsonResponse is List ? jsonResponse : jsonResponse['data'];
        setState(() {
          petAds = List<Map<String, dynamic>>.from(pets);
        });
      } else {
        throw Exception('Failed to load pet ads');
      }
    } catch (e) {
      print('Error fetching pet ads: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: petAds.length,
      itemBuilder: (context, index) {
        Uint8List imageBytes;
        try {
          imageBytes = base64Decode(petAds[index]['photo']);
        } catch (e) {
          imageBytes = Uint8List(0);
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: MemoryImage(imageBytes),
          ),
          title: Text('${petAds[index]['type']} - ${petAds[index]['gender']}'),
          subtitle: Text('${petAds[index]['age']} years old, ${petAds[index]['additionalInfo']}'),
        );
      },
    );
  }
}
class NewAdoptionForm extends StatefulWidget {
  const NewAdoptionForm({Key? key}) : super(key: key);

  @override
  _NewAdoptionFormState createState() => _NewAdoptionFormState();
}

class _NewAdoptionFormState extends State<NewAdoptionForm> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future submitAdoptionForm() async {
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/PetAdoption/Post'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'type': typeController.text,
          'age': ageController.text,
          'gender': genderController.text,
          'additionalInfo': infoController.text,
          'photo': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        print("Failed to post ad");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Yeni Sahiplendirme İlanı Oluştur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Hayvan Türü', labelStyle: TextStyle(color: Colors.white)),
                
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Yaş', labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Cinsiyet', labelStyle: TextStyle(color: Colors.white)),
              ),
              TextField(
                controller: infoController,
                decoration: const InputDecoration(labelText: 'Ek Bilgiler', labelStyle: TextStyle(color: Colors.white)),
                maxLines: null,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),  // Camera icon
                label: Text("Resim Seç"),
                onPressed: pickImage,
              ),
              const SizedBox(height: 10.0),
              // Display the selected image
              _image != null ? Image.file(_image!, height: 200) : Container(),
              ElevatedButton(
                onPressed: submitAdoptionForm,
                child: const Text("Sahiplendirme İlanı Oluştur"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}