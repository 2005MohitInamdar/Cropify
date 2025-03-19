import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class farmer_settings_page extends StatelessWidget {
  const farmer_settings_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dealer Settings Page"),),
      body: Center(child: Text("Welcome to Settings Page")),
    );
  }
}
