import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class both_profile_page extends StatelessWidget {
  const both_profile_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("both Profile Page"),),
      body: Center(child: Text("Welcome to Profile Page")),
    );
  }
}
