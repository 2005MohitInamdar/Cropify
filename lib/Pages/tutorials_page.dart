import 'package:flutter/material.dart';
import '../main.dart';
import 'Form_Selection_page/Form_Selector_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TutorialPage(),
    );
  }
}

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _tutorialData = [
    {
      "title": "Welcome to MyApp!",
      "description": "This app helps you organize your tasks efficiently.",
      // "image": "assets/tutorial1.png", // Replace with your image path
    },
    {
      "title": "Stay Productive",
      "description": "Track your daily goals and complete them on time.",
      // "image": "assets/tutorial2.png",
    },
    {
        "title": "Seller",
        "description": "Information about seller!",
        // "image": "assets/tutorial3.png",
    },
    {
        "title": "Buyer",
        "description": "Information on buyer!",
        // "image": "assets/tutorial3.png",
    },
    {    "title": "Both",
         "description": "Information on both!",
      // "image": "assets/tutorial3.png",
    },
  ];

  void _onNext() {
    if (_currentPage < _tutorialData.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _finishTutorial();
    }
  }

  void _finishTutorial() {
    // Navigate to the main page of your app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _tutorialData.length,
                  itemBuilder: (context, index) {
                    final data = _tutorialData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          data["title"]!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          data["description"]!,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishTutorial,
                    child: Text("Skip"),
                  ),
                  Row(
                    children: List.generate(
                      _tutorialData.length,
                          (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 16 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onNext,
                    child: Text(_currentPage == _tutorialData.length - 1
                        ? "Finish"
                        : "Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      // ]
        // )
      ),
    );

  }
}

class MainAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main App Page"),
      ),
      body: Center(
        child: Text(
          "Welcome to the main app!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
