import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demomain/Pages/Farmer_Home_Pages/Farmer_Home_Page.dart';
import 'package:demomain/Pages/both_Home_Page/both_navigation.dart';
import 'package:demomain/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Pages/Dealer_Home_Page/Dealer_Navigation.dart';
import 'Pages/Form_Selection_page/Form_Selector_page.dart';
import 'Pages/signUpPage.dart';
import 'Pages/loginPage.dart';
import 'Pages/tutorials_page.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyArvVqXAl8L8OR784yhZdqrrjYPGuKIw5M", appId: "1:928651328992:web:5df7102a7c92f727ae7f85", messagingSenderId: "928651328992", projectId: "fir-cropify-testing"));
  }
  await Firebase.initializeApp();
  runApp(CropifyApp());
}


class CropifyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => TutorialPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cropify',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      await _googleSignIn.signOut();
      // Attempt to sign in the user with Google
      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // Retrieve authentication details
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a credential using the tokens
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => form_Selector_Page()),
        );
        // Retrieve the signed-in user
        final User? user = userCredential.user;

        if (user != null) {
          showToast(message: "Successfully signed in with Google!");

          print("User ID: ${user.uid}");
          print("User Email: ${user.email}");
          print("User Display Name: ${user.displayName}");

          await _firestore.collection("Users").doc(user.uid).set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'signInMethod': 'google',
          }, SetOptions(merge: true));
        } else {
          print("Google Sign-In failed: User is null.");
        }
      } else {
        print("User cancelled the Google sign-in process.");
      }
    } catch (error) {
      // Handle errors during sign-in
      print("An error occurred while signing in: $error");
    }
  }



  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cropify'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Welcome to Cropify',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                //Sign In With Google
                ElevatedButton.icon(
                  onPressed: () => _signInWithGoogle(context),
                  icon: Icon(Icons.account_circle, size: 24),
                  label: Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),


                //Sign In With Email
                SizedBox(height: 16),
                ElevatedButton.icon(
                  // onPressed: () => CreateAccount(context),
                  onPressed: () => {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginPage()),
                  ),
                  },
                  icon: Icon(Icons.email, size: 24),
                  label: Text('Sign in with Email'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),



                //Sign In With Facebook
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.facebook, size: 24),
                  label: Text('Sign in with Facebook'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () => _navigateToEnterDetails(context),
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEnterDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccount()),
    );
  }
}
class ActionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      //   onWillPop: () async {
      //     SystemNavigator.pop(); // Close the app
      //     return Future.value(false); // Prevent default back behavior
      //   },
      //   child:
    Scaffold(
      appBar: AppBar(
        title: Text('Actions'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Farmer_Navigation_Page()),
                );
              },
              child: Text('Seller'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dealer_Navigation_Page()),
                );
              },
              child: Text('Buyer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => both_Navigation_Page()),
                );
              },
              child: Text('Both'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
