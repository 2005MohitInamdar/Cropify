// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void showToast({required String message}) {
//   Fluttertoast.showToast(
//     msg: message, // message to be displayed
//     toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//     gravity: ToastGravity.BOTTOM, // or ToastGravity.TOP, etc.
//     timeInSecForIosWeb: 1, // optional, for iOS/Web platforms
//     // backgroundColor: Colors.blue, // optional
//     textColor: Colors.black, // optional
//     fontSize: 16.0, // optional
//   );
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message, // Message to be displayed
    toastLength: Toast.LENGTH_SHORT, // Toast duration: SHORT or LONG
    gravity: ToastGravity.BOTTOM, // Display position: BOTTOM, TOP, CENTER
    timeInSecForIosWeb: 1, // Duration for iOS/Web platforms
    backgroundColor: Colors.blue, // Background color for better visibility
    textColor: Colors.white, // Text color
    fontSize: 16.0, // Font size
  );
}
