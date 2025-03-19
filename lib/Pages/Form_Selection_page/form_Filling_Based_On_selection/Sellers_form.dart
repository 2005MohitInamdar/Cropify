// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../../main.dart';
//
// class sellers_Form extends StatelessWidget {
//   const sellers_Form({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Seller's Form Page"),
//             SizedBox(height: 20,),
//             ElevatedButton(
//                 onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInPage()));
//                 },
//                 child: Text("Submit"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(200, 50),
//               )
//             )
//
//
//           ],
//         ),
//
//
//       )
//     );
//   }
// }







import 'package:demomain/main.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../Farmer_Home_Pages/Farmer_Home_Page.dart';

class SellerRegistrationForm extends StatefulWidget {
  @override
  _SellerRegistrationFormState createState() => _SellerRegistrationFormState();
}

class _SellerRegistrationFormState extends State<SellerRegistrationForm> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form data
  String? businessName;
  String? location;
  String? productType;
  String? contactInfo;

  // void nextStep() {
  //   if (_currentStep < _totalSteps - 1) {
  //     setState(() {
  //       _currentStep++;
  //     });
  //     _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  //   }
  // }

  void nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitForm();
    }
  }

  void submitForm() {
    print("Business Name: $businessName");
    print("Location: $location");
    print("Product Type: $productType");
    print("Contact Info: $contactInfo");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Farmer_Navigation_Page()),
    );
  }


  void previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seller Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StepProgressIndicator(
              totalSteps: _totalSteps,
              currentStep: _currentStep + 1,
              size: 8,
              selectedColor: Colors.blue,
              unselectedColor: Colors.grey[300]!,
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildStep(
                      "Business Name", "Enter your business name", (value) =>
                  businessName = value),
                  buildStep(
                      "Location", "Enter your business location", (value) =>
                  location = value),
                  buildStep("Product Type", "What do you sell?", (value) =>
                  productType = value),
                  buildStep(
                      "Contact Info", "Enter your phone or email", (value) =>
                  contactInfo = value),
                ],
              ),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Ensure proper alignment by using Expanded with an empty Container when Back is hidden
            if (_currentStep > 0)
              ElevatedButton(
                onPressed: previousStep,
                child: Text("Back"),
              )
            else
              Expanded(child: Container()), // Keeps spacing correct

            ElevatedButton(
              onPressed: () {
                if (_currentStep == _totalSteps - 1) {
                  // Navigate to SuccessScreen on submit
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Farmer_Navigation_Page()),
                  );
                } else {
                  nextStep();
                }
              },
              child: Text(_currentStep == _totalSteps - 1 ? "Submit" : "Next"),
            ),
          ],
        ),
          ],
        ),
      ),
    );
  }

  Widget buildStep(String title, String hint, Function(String) onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              onChanged(value);
            });
          },
        ),
      ],
    );
  }

}