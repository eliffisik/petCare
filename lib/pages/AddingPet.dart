import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddingPet extends StatefulWidget {

  
  final String token;
  final String userId;
  

  const AddingPet({
    Key? key,
   
    required this.token,
    required this.userId,
  }) : super(key: key);
  
  @override
  _AddingPetState createState() => _AddingPetState();
}

class _AddingPetState extends State<AddingPet> {
  File? _image;
  final _petNameController = TextEditingController();
  final _petBreedController = TextEditingController();
  String? _selectedPetCategory;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<void> addPet() async {
    if (_image == null || _selectedPetCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please pick an image and select a category")),
      );
      return;
    }

    List<int> imageBytes = await _image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    var response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/Pet/Post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": widget.userId,
        'name': _petNameController.text,
        'breed': _petBreedController.text,
        'categoryId': int.tryParse(_selectedPetCategory!) ?? 0, 
        'imagePath': base64Image,
      }),
    );

    if (response.statusCode == 200) {
      print("Pet added successfully!");
      
    } else {
      print("Failed to add pet: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(193, 104, 183, 232),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Evcil Hayvan Ekleme',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(75),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.add_a_photo, color: Colors.grey[800], size: 50),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _petNameController,
              decoration: InputDecoration(
                labelText: 'Hayvanın Adı',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _petBreedController,
              decoration: InputDecoration(
                labelText: 'Hayvanın Cinsi',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              dropdownColor: Color.fromARGB(255, 82, 82, 86),
              value: _selectedPetCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPetCategory = newValue;
                });
              },
              items: ['Kedi', 'Köpek', 'Kuş', 'Tavşan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addPet,
              child: Text('Evcil Hayvan Ekle', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
