import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../RoundedButton.dart';

class AddingPet extends StatefulWidget {
  const AddingPet({super.key});

  @override
  _AddingPetState createState() => _AddingPetState();
}

class _AddingPetState extends State<AddingPet> {
  File? _image;
  final _petNameController = TextEditingController();
  final _petBreedController = TextEditingController();
  String? _selectedPetCategory;

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          print("Image picked: ${pickedFile.path}");
          _image = File(pickedFile.path);
        } else {
          print("Image picking canceled");
        }
      });
    } catch (e) {
      print("Error picking image: $e");
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
        'AddPet',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add Your Pet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(193, 104, 183, 232),
              ),
            ),

            const SizedBox(height: 10),
            // Image upload area
            InkWell(
              onTap: pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey, 
                  borderRadius: BorderRadius.circular(10),
                  image: _image != null
                      ? DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _image == null
                    ? const Icon(Icons.camera_alt, color: Colors.white70)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            // Pet name input field
            TextField(
              controller: _petNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your pet name',
              ),
            ),
            const SizedBox(height: 20),
            // Pet breed input field
            TextField(
              controller: _petBreedController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your pet breed', 
              ),
            ),
            const SizedBox(height:60),
            const Text(
              'Select category of your pet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Image 1 tapped');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/8.png',
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Image 2 tapped');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/9.png',
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Image 3 tapped');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/13.png',
                      height: 50,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Image 4 tapped');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/14.png',
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
            // Pet category dropdown field
            // DropdownButton<String>(
            //   hint: Text('Select category of your pet'),
            //   value: _selectedPetCategory,
            //   items: <String>['Dog', 'Cat', 'Bird', 'Rabbit', 'Other']
            //       .map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedPetCategory = newValue;
            //     });
            //   },
            // ),
            // Add more fields as per your requirements
            // ...
            const SizedBox(height: 10),
            RoundedButton(
              btnText: 'Add Your Pet',
              onBtnPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
}