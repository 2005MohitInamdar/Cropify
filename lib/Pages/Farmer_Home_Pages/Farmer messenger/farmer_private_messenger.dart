import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/chatPage.dart';

class farmer_private_chat extends StatefulWidget {
  const farmer_private_chat({super.key});

  @override
  State<farmer_private_chat> createState() => _farmer_private_chatState();
}

class _farmer_private_chatState extends State<farmer_private_chat> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current loggedin users
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot){
            if(snapshot.hasError){
              return const Text("Error");
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Text("Loading...");
            }
            return ListView(
              children: snapshot.data!.docs.map<Widget>((doc)=> _buildUserListItem(doc)).toList(),
            );
        });
  }

  //build individual user list item
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if(_auth.currentUser!.email != data['email']){
      return ListTile(
      title: Text(data['email']),
      onTap: (){
      //go to the chat page of the clicked user
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
          receiverUserEmail: data['email'],
          receiverUserID: data['uid'],
        )));
      },
    );
  }else{
      return Container();
    }
    //display all users except for the current users

  }

}
