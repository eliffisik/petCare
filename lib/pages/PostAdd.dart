import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({Key? key}) : super(key: key);

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
       backgroundColor: Color.fromARGB(255, 82, 82, 86),
      appBar: AppBar(
        title: const Text('Post Oluştur'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Başlık
              TextField(
                
                controller: _baslikController,
                decoration: InputDecoration(
                  labelText: 'Başlık',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // İçerik
              TextField(
                controller: _icerikController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'İçerik',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // Resim seçme
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
                      icon: const Icon(Icons.add_photo_alternate),
                    ),
              const SizedBox(height: 16.0),
              // Gönderme butonu
              ElevatedButton(
                onPressed: () {
                  // Gönderme işlemini buraya yazabilirsiniz
                  // Örneğin, API'ye post isteği yapabilirsiniz
                  // ...

                  Navigator.pop(context);
                },
                child: const Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}