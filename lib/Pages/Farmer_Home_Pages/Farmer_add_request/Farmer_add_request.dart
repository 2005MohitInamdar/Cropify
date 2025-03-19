import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class farmer_add_request extends StatelessWidget {
  const farmer_add_request({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Farmer's request"),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Post"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              )
            )
          ],
        )
      ),
    );
  }
}
