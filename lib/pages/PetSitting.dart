import 'package:flutter/material.dart';

import 'Messaging.dart';

class PetSitting extends StatefulWidget {
  const PetSitting({super.key});

  @override
  _PetSittingState createState() => _PetSittingState();
}

class _PetSittingState extends State<PetSitting> {
  List<PetSitter> petSitters = [
    PetSitter(
      isim: "Ayşe",
      resim: "assets/pet_sitter_1.png",
      puan: 4.8,
      yorumSayisi: 120,
      fiyat: 50,
      sehir: "İstanbul",
      tecrube: 5,
      hizmetler: ["Yürüyüş", "Oyun Oynama"],
    ),
    PetSitter(
      isim: "Mehmet",
      resim: "assets/pet_sitter_2.png",
      puan: 4.5,
      yorumSayisi: 50,
      fiyat: 40,
      sehir: "Ankara",
      tecrube: 3,
      hizmetler: ["Yürüyüş", "Ev Temizliği"],
    ),
    // Diğer bakıcılar buraya eklenebilir.
  ];

  String aramaTerimi = "";

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
            // Arama çubuğu
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
                    !petSitters[index].isim
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
  String isim;
  String resim;
  double puan;
  int yorumSayisi;
  int fiyat;
  String sehir;
  int tecrube;
  List<String> hizmetler;

  PetSitter({
    required this.isim,
    required this.resim,
    required this.puan,
    required this.yorumSayisi,
    required this.fiyat,
    required this.sehir,
    required this.tecrube,
    required this.hizmetler,
  });
}

// Bakıcı kartı widget'ı
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
                    backgroundImage: AssetImage(petSitter.resim), // Resim yolunu düzelt
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petSitter.isim,
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
                          petSitter.puan.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          " (${petSitter.yorumSayisi} yorum)",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${petSitter.fiyat} TL/saat",
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
                    petSitter.sehir,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${petSitter.tecrube} yıl tecrübe",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    petSitter.hizmetler.join(", "),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

  IconButton(
        
        onPressed: () {
          // Mesaj gönderme işlevi burada tetiklenir
          // Örneğin, bir AlertDialog gösterebilirsiniz
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor:  const Color.fromARGB(193, 104, 183, 232),
                backgroundColor: const Color.fromARGB(193, 213, 223, 228), 
                title: const Text("Mesaj Gönder"),
                content: const Text("Bakıcıya mesaj göndermek istediğinize emin misiniz?"),
                actions: [
                  TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Evet seçildiğinde mesajlaşma sayfasına git
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
                      Navigator.of(context).pop(); // AlertDialog'ı kapat
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
            // Detaylar butonu
           

          ]
        )
      ),
    );

  }
}
