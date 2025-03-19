import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demomain/chat_model/messageIncoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class chatService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(String receiverID, String message)async{
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderid: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );

    //construct chat room id from current user and receiver id {sorted to ensure uniqueness}
    List<String> ids = [currentUserID, receiverID];
    ids.sort();

    String chatRoomId = ids.join("_");
    //add new message to database
    await _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());
  }

  // Future<void> sendMessage(String receiverID, String message) async {
  //   // Ensure a user is logged in
  //   User? user = _auth.currentUser;
  //
  //   if (user == null) {
  //     print("❌ User is NOT logged in!");
  //     return;
  //   }
  //
  //   // Get current user info
  //   final String currentUserID = user.uid;
  //   final String currentUserEmail = user.email ?? "Unknown Email";
  //   final Timestamp timestamp = Timestamp.now();
  //
  //   // Debugging statements
  //   print("✅ Current User ID: $currentUserID");
  //   print("✅ Current User Email: $currentUserEmail");
  //   print("📩 Sending message from: $currentUserID to: $receiverID");
  //
  //   // Create a new message
  //   Message newMessage = Message(
  //     senderid: currentUserID,  // Ensure 'senderid' is assigned correctly
  //     senderEmail: currentUserEmail,
  //     receiverID: receiverID,
  //     message: message,
  //     timestamp: timestamp,
  //   );
  //
  //   print("📌 Sender ID inside Message object: ${newMessage.senderid}");
  //
  //   // Construct chat room ID
  //   List<String> ids = [currentUserID, receiverID];
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //
  //   // Add new message to database
  //   await _firestore
  //       .collection("chat_rooms")
  //       .doc(chatRoomId)
  //       .collection("messages")
  //       .add(newMessage.toMap());
  //
  //   print("✅ Message sent successfully!");
  // }



  //GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userID, String otherUserId){
    //construct chatroom id from user ids {sorted to ensure it matches the id used when sending messages}
    List<String> ids = [userID, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore.
    collection("chat_rooms").
    doc(chatRoomId).
    collection("messages").
    orderBy("timestamp", descending: false)
        .snapshots();
  }


}