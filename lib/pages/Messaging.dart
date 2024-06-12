import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PetSitting.dart';  

class Message {
  final String text;
  final bool isSender;

  Message({required this.text, required this.isSender});
}

class Messaging extends StatefulWidget {
  final PetSitter petSitter;
  final String token;
  final String userId;
  final String senderRole;
  final String receiverRole;

  const Messaging({
    Key? key,
    required this.petSitter,
    required this.token,
    required this.userId,
    required this.senderRole,
    required this.receiverRole,
  }) : super(key: key);

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

 Future<void> fetchMessages() async {
  
  final String apiUrl = "http://10.0.2.2:5000/api/Messages/conversation/${widget.userId}/${widget.petSitter.userId}";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> messagesJson = jsonDecode(response.body);
      setState(() {
        _messages = messagesJson.map((msg) => Message(
          text: msg['content'],
          isSender: msg['senderId'] == widget.userId,
        )).toList();
      });
    } else {
      print('Failed to load messages: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading messages: $e');
  }
}


 
  Future<void> _sendMessage(String text) async {
  final String apiUrl = "http://10.0.2.2:5000/api/Messages";

  var requestBody = jsonEncode({
    "senderId": widget.userId,
    "senderRole": widget.senderRole,
    "receiverId": widget.petSitter.userId, 
    "receiverRole": widget.receiverRole,
    "content": text,
  });

  print("Sending Message: $requestBody");

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      fetchMessages();  // Refresh messages after sending a new one
      _controller.clear();
    } else {
      print('Failed to send message: ${response.statusCode}');
      print('Response body: ${response.body}'); 
    }
  } catch (e) {
    print('Error sending message: $e');
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
        title: const Text('Mesajlaşma'),
      ),
      body: Column(
        children: [
          // Displaying pet sitter information
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(193, 170, 191, 205),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bakıcı: ${widget.petSitter.firstName} ${widget.petSitter.lastName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Şehir: ${widget.petSitter.city}'),
                  Text('Tecrübe: ${widget.petSitter.yearsOfExperience} yıl'),
                  Text('Hizmetler: ${widget.petSitter.skills.join(', ')}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Message message = _messages[index];
                return MessageBubble(message: message.text, isSender: message.isSender);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Mesajınızı yazın...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
