import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

import 'characterCardsAdd.dart';
import 'db_helper.dart';

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterCardsAdd()));
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

List<Map<String, dynamic>> characterData = [];
class _CharacterCardBodyState extends State<CharacterCardBody> {

  var db = UserDatabaseProvider();
  Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere

    characterData = await db.getCharacterData(db.database);
    setState(() {

    });
    if (characterData.isNotEmpty) {
      // Process retrieved data
      for (var character in characterData) {
        print(character);
        print(characterData[0]["imgPath"].replaceFirst("File: ", ""));
        // Print other character details as needed
      }
    } else {
      print('No character data found.');
    }


  }


  @override
  Widget build(BuildContext context) {
    getData();
    print(characterData.length);
    if(characterData.length == 0)
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
    else
      return Container(
        margin: EdgeInsets.all(20),
        child: Container(
        child: SingleChildScrollView(
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
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  children: [
                for(int i = 0 ; i < characterData.length ; i++ )
                  Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 400,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                             SizedBox(height: 10,),
                             Image(image: FileImage(File(characterData[i]["imgPath"].replaceFirst("File: '", "").replaceFirst("'", ""))),
                               width: MediaQuery.of(context).size.width * 0.35,
                               height: 120,
                             ),
                             SizedBox(height: 5,),
                             Text(characterData[i]["name"]),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                               child: Row(
                                 children: [
                                   SizedBox(width: 5,),
                                   Column(
                                     children: [
                                       Text(characterData[i]["class"].toString()),
                                       SizedBox(height: 10,),
                                       Text(characterData[i]["level"].toString())
                                     ],
                                   ),
                                   SizedBox(width: 5,),
                                   Container(
                                     width: 2,
                                     height: 80,
                                     color: Colors.grey,
                                   ),
                                   Column(
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Power                "),
                                           Text(characterData[i]["power"].toString(),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Dexerity             "),
                                           Text(characterData[i]["dexerity"].toString(),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Perception        "),
                                           Text(characterData[i]["perception"].toString(),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Intelligence       "),
                                           Text(characterData[i]["intelligence"].toString(),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 5,),
                                       ],
                                   ),
                                 ],
                               ),
                             ),
                          SizedBox(height: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 2,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(characterData[i]["description"])
                                ],
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            )
          
          
            ]
              ),
        ),
      ),
    );

  }
}


