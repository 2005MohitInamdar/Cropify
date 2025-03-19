import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dealer_add_request/dealer_add_request.dart';

class dealer_dealerTrending extends StatelessWidget {
  const dealer_dealerTrending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Dealer's Page"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the + button
          Navigator.push(context, MaterialPageRoute(builder: (context)=>dealer_add_request()));
          print('+ button pressed');
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );;
  }
}
