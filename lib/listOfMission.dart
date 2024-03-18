import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'MissionAdd.dart';
import 'db_helper.dart';
import 'home.dart';

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
                MissionAdd.id = 0;
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

    if(missionData.length == 0)
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
            Home.lang == "en" ? Text("List of missions") : Text("Список миссий"),
            SizedBox(height: 40,),
            Home.lang == "en" ?  Text("It's empty here",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff686868)
              ),
            ) : Text("",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff686868)
              ),
            ),
        Container(
              width: MediaQuery.of(context).size.width*0.5,
              child:Home.lang == "en" ?   Text("To add a mission , click on the mission card to move it",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ) : Text("Чтобы добавить миссию, нажмите на кнопку со знаком плюс.",
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
              child: Home.lang == "en" ?  Text("Hold your finger on the mission card to move it.",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff686868),
                ),
              ) : Text("Удерживайте палец на карточке миссии, чтобы переместить ее.",
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
              child: Home.lang == "en" ?   Text("Swipe the card to the left to change or delete the mission. Swipe the card to the right to confirm the completition or non-completion of the mission",
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff686868),
                ),
              ) : Text("Проведите карточкой влево, чтобы изменить или удалить миссию.Проведите карточкой вправо, чтобы подтвердить завершение или незавершение миссии.",
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

    else
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
          Text("List of missions"),
          SizedBox(height: 40,),
          for(int i = 0 ; i<missionData.length ; i++)
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                ),
                child: SwipeActionCell(
                  key: ObjectKey('swipeKey1'),
                  backgroundColor: Colors.transparent,
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                      onTap: (completionHandler) {
                        // Handle swipe action (e.g., perform action on swipe right)
                        completionHandler(true);
                        db.deleteMission(db.database, missionData[i]["id"]);
                      },
                      color: Colors.red,
                      icon: Icon(Icons.delete,
                      color: Colors.white,),
                      title: "delete",
                    ),
                    SwipeAction(
                      onTap: (completionHandler) {
                        // Handle swipe action (e.g.,
                        // perform action on swipe right)
                        completionHandler(true);
                        MissionAdd.id = missionData[i]["id"];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MissionAdd()));

                      },
                      color: Colors.blue,
                      icon: Icon(Icons.edit_note_sharp,
                      color: Colors.white,),
                      title: "edit",
                    ),
                  ],
                  leadingActions: <SwipeAction>[
                    SwipeAction(
                      onTap: (completionHandler) {
                        // Handle swipe action (e.g., perform action on swipe left)
                        completionHandler(true);
                        db.updateMissionStatusDataById(db.database, missionData[i]["id"], "Failed");
                      },
                      color: Colors.red,
                      icon: Icon(Icons.sms_failed_outlined,
                        color: Colors.white,
                      ),
                      title: "Failed"
                    ),
                    SwipeAction(
                      onTap: (completionHandler) {
                        completionHandler(true);
                        db.updateMissionStatusDataById(db.database, missionData[i]["id"], "Complete");
                      },
                      color: Colors.green,
                      icon: Icon(Icons.done,
                        color: Colors.white,
                      ),
                      title: "Complete",
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(missionData[i]["name"]),
                          Text(missionData[i]["status"]),
                          SizedBox(height: 6,),
                          Text(missionData[i]["description"]),
                          if(missionData[i]["numeric"] == 1)
                              Slider(
                                  value: missionData[i]["currnumber"].toDouble(),
                                  max: missionData[i]["number"].toDouble(),
                                  divisions: 100,
                                  label: missionData[i]["currnumber"].round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      db.updateMissionDataById(db.database,missionData[i]["id"] , value.toInt());
                                    });
                                  },
                                ),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
       )
      );
  }
}
