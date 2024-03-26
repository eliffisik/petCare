import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _results = [];

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
          _buildSearchBar(),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Bir şey ara...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _results.clear();
            },
          ),
        ),
        onChanged: (text) {
          // Arama fonksiyonu
          _results = _performSearch(text);
          setState(() {});
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_results[index]),
          );
        },
      ),
    );
  }

  List<String> _performSearch(String text) {
    // Arama algoritması
    // Örnek: Veritabanından veya API'den gelen sonuçları filtreleme
    return [];
  }
}
