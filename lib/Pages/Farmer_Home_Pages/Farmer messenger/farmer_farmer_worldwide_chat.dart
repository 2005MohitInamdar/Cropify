import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class farmer_farmer_worldwide_chat extends StatelessWidget {
  const farmer_farmer_worldwide_chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Seller's Worldwide Chat",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0), // Adjusted padding
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(child: MessageBox()),
                        IconButton(
                          onPressed: () => _pickFile(),
                          icon: Icon(Icons.attach_file, size: 30, color: Colors.grey[700]),
                        ),
                        IconButton(
                          onPressed: () => _openCamera(),
                          icon: Icon(Icons.camera_alt, size: 30, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10), // Added spacing
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, size: 30, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Opens the Camera
  void _openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print("Captured Image: ${image.path}");
    }
  }

  // Opens File Picker
  void _pickFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      print("Selected File: ${file.path}");
    }
  }
}

class MessageBox extends StatefulWidget {
  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Type a message...',
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}