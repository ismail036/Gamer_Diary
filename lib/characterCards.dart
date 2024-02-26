import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          // Replace 'background_image.jpg' with your image path
          fit: BoxFit
              .cover, // You can change the BoxFit as per your requirement
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CharacterCardBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: Color(0xffFFCB1A),
              child: Icon(
                Icons.keyboard_backspace_rounded,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 25,),
            FloatingActionButton(
              onPressed: () {
                // Add functionality for the second button here
              },
              backgroundColor: Color(0xffFFCB1A), // Change color as needed
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterCardBody extends StatefulWidget {
  const CharacterCardBody({super.key});

  @override
  State<CharacterCardBody> createState() => _CharacterCardBodyState();
}

class _CharacterCardBodyState extends State<CharacterCardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Image.asset(
                'assets/appBarImage.png',
                width: 80,
              ), // Bu kısımda resmi gösterin
            ),
            SizedBox(height: 5,),
            Text("Character cards"),
            SizedBox(height: 100,),
            Text("It's empty here",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff686868)
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text("In order to add a character, click on the plus sign button.",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ),
            ),
            Image(image: AssetImage("assets/maskgroup1.png"),
              width: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text("Hold your finger on the card to move it.",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ),
            ),
            Image(image: AssetImage("assets/maskgroup2.png"),
              width: 200,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text("There will also be buttons for editing and deleting the card.",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/maskgroup4.png")),
                SizedBox(width: 5,),
                Image(image: AssetImage("assets/maskgroup3.png")),

              ],
            )



        ],
      ),
      ),
    );
  }
}


