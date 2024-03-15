import 'package:flutter/material.dart';

import 'MissionAdd.dart';
import 'db_helper.dart';

class ListOfMission extends StatelessWidget {
  const ListOfMission({super.key});

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
        body: ListOfMissionBody(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => MissionAdd()));
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

class ListOfMissionBody extends StatefulWidget {
  const ListOfMissionBody({super.key});

  @override
  State<ListOfMissionBody> createState() => _ListOfMissionBodyState();
}

List<Map<String, dynamic>> missionData = [];
class _ListOfMissionBodyState extends State<ListOfMissionBody> {


  var db = UserDatabaseProvider();
  Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere

    missionData = await db.getMissionData(db.database);
    setState(() {

    });
    if (missionData.isNotEmpty) {
      // Process retrieved data
      for (var character in missionData) {
        print(character);
        // Print other character details as needed
      }
    } else {
      print('No character data found.');
    }
  }


  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      margin: EdgeInsets.all(20),
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 21,),
            Center(
              child: Image.asset(
                'assets/appBarImage.png',
                width: 80,
              ), // Bu kısımda resmi gösterin
            ),
            SizedBox(height: 5,),
            Text("Character cards"),
            SizedBox(height: 40,),
            Text("It's empty here",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff686868)
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text("To add a mission , click on the mission card to move it",
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
              child: Text("Hold your finger on the mission card to move it.",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ),
            ),
            Image(image: AssetImage("assets/missionInfo.png"),
              width: 200,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text("Swipe the card to the left to change or delete the mission. Swipe the card to the right to confirm the completition or non-completion of the mission",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff686868),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/listMission.png"),
                  width: 150,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
