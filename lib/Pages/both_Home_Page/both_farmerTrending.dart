import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Farmer_Home_Pages/Farmer_add_request/Farmer_add_request.dart';

class both_farmerTrending extends StatelessWidget {
  const both_farmerTrending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Farmer's Page"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the + button
          Navigator.push(context, MaterialPageRoute(builder: (context)=>farmer_add_request()));
          print('+ button pressed');
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );;
  }
}
