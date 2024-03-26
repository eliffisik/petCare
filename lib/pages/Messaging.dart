import 'package:flutter/material.dart';

import 'PetSitting.dart';

class Messaging extends StatefulWidget {
  final PetSitter petSitter;

  const Messaging({super.key, required this.petSitter});

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = []; // Store messages here

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 109, 109, 113),
      appBar: AppBar(
        title: const Text("Mesajlaşma"),
      ),
      body: Column(
        children: [
          // Display pet sitter information
          Padding(
            
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromARGB(193, 170, 191, 205),
              child: Padding(
                
                padding: const EdgeInsets.all(8.0),
                child: Column(
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                   
                    Text(
                      "Bakıcı: ${widget.petSitter.isim}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Şehir: ${widget.petSitter.sehir}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Tecrübe: ${widget.petSitter.tecrube.toString()} yıl",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Hizmetler: ${widget.petSitter.hizmetler.join(", ")}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Messaging area
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Message message = _messages[index];
                return MessageBubble(
                  message: message.text,
                  isSender: message.isSender,
                );
              },
            ),
          ),
          // Message input area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Mesajınızı yazın...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      // Send message
                      setState(() {
                        _messages.add(Message(
                            text: _messageController.text, isSender: true));
                        _messageController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
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

  const MessageBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isSender ? 15 : 0),
              topRight: Radius.circular(isSender ? 0 : 15),
              bottomLeft: const Radius.circular(15),
              bottomRight: const Radius.circular(15),
            ),
            color: isSender ? Colors.blue[100] : Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSender;

  Message({required this.text, required this.isSender});
}
