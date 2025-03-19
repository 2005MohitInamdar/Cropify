import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demomain/chat/chatServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final chatService _chatService = chatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    // Only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      // Clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: _buildMessageList(),
          ),
          // User Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }




  // Build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    // Null check before converting to Map
    if (document.data() == null) {
      return const SizedBox();
    }

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Align messages based on who is typing
    print("Sender ID: ${data['senderid']}, Current User ID: ${_auth.currentUser!.uid}");

    var alignment = (data['senderid'] == _auth.currentUser!.uid)

        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Limit message width to 70% of screen
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(data['senderEmail'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(data['message'], style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }




  // Build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Textfield
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Enter a message",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Send Button
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send, size: 30, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

