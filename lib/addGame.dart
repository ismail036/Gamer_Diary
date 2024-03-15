import 'package:flutter/material.dart';

import 'db_helper.dart';


class AddGame extends StatelessWidget {
  const AddGame({super.key});

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
        body: AddGameBody(),
      ),
    );
  }
}

class AddGameBody extends StatefulWidget {
  const AddGameBody({super.key});

  @override
  State<AddGameBody> createState() => _AddGameBodyState();
}

class _AddGameBodyState extends State<AddGameBody> {

  var gameName = "";

  Future<void> saveGame() async {
    var db = UserDatabaseProvider();
    await db.open();
    await db.addGameData(gameName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 350,),
      Text("Enter the name",
        textAlign: TextAlign.left,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFE58A00), // #E58A00 in hex
            width: 1.0, // 1px
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter the name',
          ),
            onChanged: (value) {
              setState(() {
                gameName =
                    value; // Update the gameName variable with the entered text
              });
            }
        ),



      ),
        SizedBox(height: 350,),
        Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    FloatingActionButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    backgroundColor: Color(0xffFF1A1A ),
    child: Icon(
    Icons.block_flipped,
    color: Colors.white,
    ),
    ),
    SizedBox(width: 25,),
    FloatingActionButton(
    onPressed: () {
      saveGame();
    },
    backgroundColor: Color(0xff1A91FF), // Change color as needed
    child: Icon(
    Icons.save,
    color: Colors.white,
    ),
    ),
    ],
    ),

    SizedBox(height: 15,),



    ]
    ),
    ),
    );
  }
}



