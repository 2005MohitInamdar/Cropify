import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderid;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderid,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp
  });

  // Map<String, dynamic> toMap(){
  //   return {
  //     'senderid': senderid,
  //     'senderEmail': senderEmail,
  //     'receiverID': receiverID,
  //     'message': message,
  //     'timestamp': timestamp,
  //   };
  // }

  Map<String, dynamic> toMap() {
    print("🔥 Converting Message to Map: Sender ID - $senderid");  // Debugging
    return {
      'senderid': senderid,  // Ensure this key matches Firestore
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }

}