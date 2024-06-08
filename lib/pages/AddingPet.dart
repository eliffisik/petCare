import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddingPet extends StatefulWidget {
  @override
  _AddingPetState createState() => _AddingPetState();
}

class _AddingPetState extends State<AddingPet> {
  File? _image;
  final _petNameController = TextEditingController();
  final _petBreedController = TextEditingController();
  String? _selectedPetCategory;
  List<String> _categories = ['Dog', 'Cat', 'Bird', 'Rabbit']; 

  @override
  void initState() {
    super.initState();
    // Normally you would fetch categories here
  }

  Future<void> addPet() async {
    if (_selectedPetCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a category")));
      return;
    }
    var url = Uri.parse('http://10.0.2.2:5000/api/Pet/Post'); 
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _petNameController.text,
        'breed': _petBreedController.text,
        'categoryId': int.tryParse(_selectedPetCategory!) ?? 0, 
        'imagePath': _image?.path ?? '',
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
        backgroundColor: const Color.fromARGB(255, 82, 82, 86),
      appBar: 
      AppBar(
        title: Text('Add Your Pet')
        
        
        ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _petNameController,
              decoration: InputDecoration(labelText: 'Pet Name'),
            ),
            TextField(
              controller: _petBreedController,
              decoration: InputDecoration(labelText: 'Pet Breed'),
            ),
            DropdownButton<String>(
              value: _selectedPetCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPetCategory = newValue;
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: addPet,
              child: Text('Add Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
