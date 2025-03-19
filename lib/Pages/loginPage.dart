import 'package:demomain/global/common/toast.dart';
import 'package:demomain/userAuth/firebaseAuthImplementation/firebaseAuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/FormContainerWidget.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<loginPage> {

  bool _isSigning = false;

  final FireBaseAuthServices _auth = FireBaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwodController = TextEditingController();

  @override

  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwodController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // FormContainerWidget(
            //   hintText: "User ID",
            //   controller: _usernameController,
            //   isPasswordField: false,
            // ),
            // SizedBox(height: 16),


            FormContainerWidget(
              hintText: "Email",
              controller: _emailController,
              isPasswordField: false,
            ),
            SizedBox(height: 16),



            FormContainerWidget(
              hintText: "Password",
              controller: _passwodController,
              isPasswordField: true,
            ),
            SizedBox(height: 32),







            ElevatedButton(
              onPressed: () {
                _signUp();
                showToast(message: "Logging in...");
              },
              child: _isSigning? CircularProgressIndicator() : Text('Submit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _signUp() async {

    setState(() {
      _isSigning = true;

    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwodController.text;




     User? user = await _auth.signInWithEmailAndPassword(email, password);

     setState(() {
       _isSigning = false;
     });

     if(user != null){

       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => ActionPage()), // Navigate directly
       );
     }
     // else{
     //   showToast(message: "Some error happened");
     // }
  }


}
