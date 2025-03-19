import 'package:flutter/material.dart';
import '../../Farmer_Home_Pages/Farmer messenger/farmer_dealer_worldwide_chat.dart';
import '../../Farmer_Home_Pages/Farmer messenger/farmer_farmer_worldwide_chat.dart';
import '../../Farmer_Home_Pages/Farmer messenger/farmer_private_messenger.dart';

class dealerMessengerNavigationPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<dealerMessengerNavigationPage> {
// Track the selected page index
  int _selectedIndex = 0;

// List of pages to be displayed based on selection
  final List<Widget> _pages = [
    Center(child: farmer_dealer_worldwide_chat()),
    Center(child: farmer_farmer_worldwide_chat()),
    Center(child: farmer_private_chat()),
  ];

// Function to handle button presses
  void _onTopNavButtonTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 20), // Add top margin
            child: Row(
              children: [
                _buildNavButton("Buyer", 0),
                _buildNavButton("Seller", 1),
                _buildNavButton("Private", 2),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex], // Display selected page content
          ),
        ],
      ),
    );
  }

// Method to build navigation buttons
  Widget _buildNavButton(String text, int index) {
    bool isSelected = _selectedIndex == index; // Check if the button is selected

    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onTopNavButtonTapped(index),
        child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300], // Highlight selected button
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
}



