import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({Key? key, required String token, required String userId}) : super(key: key);

  @override
  _PostAddState createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _icerikController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _resim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 82, 82, 86), 
      appBar: AppBar(
        title: const Text('Share Your Animal Story', style: TextStyle(fontSize: 20)),
        backgroundColor:  const Color.fromARGB(193, 104, 183, 232),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Background image (optional)
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/forest_background.jpg'),
              //       fit: BoxFit.cover,
              //       opacity: 0.2, // Adjust opacity as needed
              //     ),
              //   ),
              //   child: // Rest of the content
              // ),

              // Title field
              TextField(
                controller: _baslikController,
                decoration: InputDecoration(
                  labelText: 'Başlık',
                  prefixIcon: const Icon(Icons.title), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Content field
              TextField(
                controller: _icerikController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'İçerik',
                  prefixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              _resim != null
                  ? Image.file(File(_resim!.path))
                  : IconButton(
                      onPressed: () async {
                        _resim = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        setState(() {});
                      },
                      icon: Column(
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          const Icon(Icons.add_photo_alternate),
                        
                        ],
                      ),
                    ),
              const SizedBox(height: 16.0),

            
           

             
              ElevatedButton(
                onPressed: () {
                  
                  Navigator.pop(context);
                },
                child: const Text('Gönder'),
                style: ElevatedButton.styleFrom(
                  primary:  const Color.fromARGB(193, 104, 183, 232),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}