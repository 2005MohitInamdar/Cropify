import 'package:demomain/Pages/Farmer_Home_Pages/user_account_pages/farmer_settings_page.dart';
import 'package:demomain/Pages/Farmer_Home_Pages/user_account_pages/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemNavigator
import '../../main.dart';
import 'Farmer_dealer_trending.dart';
import 'Farmer messenger/farmer_messenger_navigator.dart';
import 'Farmer_farmer_trending.dart';
import 'Farmer_collaboration.dart';

class Farmer_Navigation_Page extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Farmer_Navigation_Page> {
  // Track the selected page index
  int _selectedIndex = 0;

  // Function to handle sign-out logic
  // void signOut(BuildContext context) {
    // Here you can add your sign-out logic, for example, Firebase sign-out:
    // FirebaseAuth.instance.signOut();

    // After sign-out, navigate to the login page or home screen
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignInPage()),
    // );
  // }

  // List of pages that will be displayed based on selection
  final List<Widget> _pages = [
    Center(child: farmerTrending()), // Page 1 content
    Center(child: dealerTrending()), // Page 2 content
    Center(child: farmer_collaboration()), // Page 3 content
  ];

  // Function to handle button presses on bottom navigation
  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: () async {
      //   // Handle the system back button press
      //   // Close the app when the back button is pressed
      //   SystemNavigator.pop();
      //   return Future.value(false); // Prevent the default back action
      // },
      // child:
      Scaffold(
        drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Hello Seller', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => farmers_Profilepage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => farmer_settings_page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
        ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            // backgroundColor: Colors.blue,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer(); // Opens the drawer
                    },
                    child: Icon(Icons.account_circle, size: 35),
                  ),
                ),

                // IconButton(
                //   icon: Icon(Icons.account_circle, size: 35,),
                //   onPressed: () => {}, // Navigate to Account page
                // )
                //
                //
                // PopupMenuButton<String>(
                //   icon: Icon(Icons.account_circle, size: 35), // Your button icon
                //   onSelected: (value) {
                //     // Handle menu selection
                //     if (value == 'profile') {
                //       print('Profile clicked');
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=> farmers_Profilepage()));
                //       // Navigate to profile page
                //     } else if (value == 'settings') {
                //       print('Settings clicked');
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=> farmer_settings_page()));
                //
                //       // Navigate to settings page
                //     } else if (value == 'logout') {
                //       print('Logout clicked');
                //       FirebaseAuth.instance.signOut();
                //
                //       Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(builder: (context) => SignInPage()),
                //             (Route<dynamic> route) => false,
                //       );
                //       // Handle logout
                //     }
                //   },
                //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                //     PopupMenuItem<String>(
                //       value: 'profile',
                //       child: Text('Profile'),
                //     ),
                //     PopupMenuItem<String>(
                //       value: 'settings',
                //
                //       child: Text('Settings'),
                //     ),
                //     PopupMenuItem<String>(
                //       value: 'logout',
                //       child: Text('Logout'),
                //     ),
                //   ],
                // ), // Your button icon
                SizedBox(width: 10),


                Text("Hello Seller", style: TextStyle(fontSize: 25,),),
              ],
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                padding: EdgeInsets.only(top: 2.0),
                icon: Icon(Icons.message, size: 35, color: Colors.black,),  // Messenger Icon
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => farmerMessengerNavigationPage()),
                  );
                  // Handle what happens when the icon is pressed
                  print('Messenger icon pressed');
                },
              ),
            ],
          ),
        ),

        // Body content changes based on the selected index
        body: _pages[_selectedIndex],


        // Bottom navigation remains constant
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First button
                Expanded(
                  child: TextButton(
                    onPressed: () => _onBottomNavItemTapped(0),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: _selectedIndex == 0 ? Colors.blue : Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    child: Text(
                      "Seller",
                      style: TextStyle(
                        fontSize: 20,
                        color: _selectedIndex == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),

                // Second button
                Expanded(
                  child: TextButton(
                    onPressed: () => _onBottomNavItemTapped(1),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: _selectedIndex == 1 ? Colors.blue : Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),

                    ),
                    child: Text(
                      "Buyer",
                      style: TextStyle(
                        fontSize: 20,
                        color: _selectedIndex == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),

                // Third button (Collaboration)
                Expanded(
                  child: TextButton(
                    onPressed: () => _onBottomNavItemTapped(2),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: _selectedIndex == 2 ? Colors.blue : Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),


                    ),
                    child: Text(
                      "Collab",
                      style: TextStyle(
                        fontSize: 20,
                        color: _selectedIndex == 2 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // ),
    );
  }
}


