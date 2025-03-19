import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class post_farmer_request extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostCreationScreen(),
    );
  }
}

class PostCreationScreen extends StatefulWidget {
  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  PageController _pageController = PageController();
  File? _selectedImage;
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _nextPage() {
    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _previousPage() {
    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _submitPost() {
    // Handle post submission (save to database, etc.)
    print("Image: $_selectedImage, Description: ${_descriptionController.text}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post Submitted!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a Post")),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Page 1: Select Image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedImage == null
                    ? Icon(Icons.image, size: 100, color: Colors.grey)
                    : Image.file(_selectedImage!, height: 200),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _pickImage, child: Text("Select Image")),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _nextPage, child: Text("Next")),
              ],
            ),
          ),
          // Page 2: Enter Description
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: "Write a description"),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: _previousPage, child: Text("Back")),
                      ElevatedButton(onPressed: _nextPage, child: Text("Next")),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Page 3: Review & Post
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedImage != null ? Image.file(_selectedImage!, height: 200) : Container(),
                SizedBox(height: 10),
                Text(_descriptionController.text, textAlign: TextAlign.center),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: _previousPage, child: Text("Back")),
                    ElevatedButton(onPressed: _submitPost, child: Text("Post")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
