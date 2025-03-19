import 'package:demomain/Pages/Form_Selection_page/form_Filling_Based_On_selection/Both_Form_Page.dart';
import 'package:demomain/Pages/Form_Selection_page/form_Filling_Based_On_selection/Buyers_form_page.dart';
import 'package:demomain/Pages/Form_Selection_page/form_Filling_Based_On_selection/Sellers_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class form_Selector_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
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
                  MaterialPageRoute(builder: (context) => SellerRegistrationForm()),
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
                  MaterialPageRoute(builder: (context) => BuyerRegistrationForm()),
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
                  MaterialPageRoute(builder: (context) => bothRegistrationForm()),
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
  }



}