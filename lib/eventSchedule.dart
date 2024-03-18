import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gamer_diary/addEvent.dart';
import 'package:accordion/accordion.dart';
import 'MissionAdd.dart';
import 'addEventDetail.dart';
import 'addGame.dart';
import 'addMission.dart';
import 'db_helper.dart';
import 'dart:io';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import 'home.dart';


class EventSchedule extends StatelessWidget {
  EventSchedule({super.key});
  static bool isSet = true;
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
        body: EventScheduleBody(),
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
                Navigator.push(context,  MaterialPageRoute(builder: (context) => AddGame()));
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


class EventScheduleBody extends StatefulWidget {
  const EventScheduleBody({super.key});

  @override
  State<EventScheduleBody> createState() => _EventScheduleBodyState();
}



List<Map<String, dynamic>> gameData    = [];
List<Map<String, dynamic>> missionData = [];
List<Map<String, dynamic>> eventData   = [];



class _EventScheduleBodyState extends State<EventScheduleBody> {

  var db = UserDatabaseProvider();
  Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere

    gameData    = await db.getGameData(db.database);
    missionData = await db.getEventMissionData(db.database);
    eventData   = await db.getEventScheduleData(db.database);

    if(EventSchedule.isSet == false){
      setState(() {
        EventSchedule.isSet = true;
        print(missionData);
      });
    }

    if (gameData.isNotEmpty) {
      // Process retrieved data
      for (var character in gameData) {
        print(character);
        // Print other character details as needed
      }
      print(missionData);
      print(eventData);
    } else {
      print('No character data found.');
    }
  }


  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);



  Text getHours(String time ){

    String timeStr = time.split(" ")[3] + " " + time.split(" ")[4];

    // Split the string into hours and minutes
    List<String> timeParts = timeStr.split(" ");

    // Extract hours and minutes
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Format hours and minutes with leading zeros if needed
    String formattedTime = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";

    return Text(formattedTime ,style: (TextStyle(fontSize: 12)), );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });

    if(gameData.length == 0)
      return Container(
      margin: EdgeInsets.all(20),
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
              SizedBox(height: 20,),
              Home.lang == "en" ?   Text("It's empty here",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff686868)
                ),
              ) : Text(""),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Home.lang == "en" ?  Text("To add a game to the table, click on the plus sign button.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ) : Text("Чтобы добавить игру в таблицу, нажмите на кнопку со знаком плюс.",
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
                child:Home.lang == "en" ?  Text('In order to add an "event" or "mission", click on the appropriate buttons.',
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ) : Text('Для того чтобы добавить "ивент" или "миссию", нажмите на соответствующие кнопки.',
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ),
              ),
              Image(image: AssetImage("assets/eventMissionClick.png"),
                width: 120,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Home.lang == "en" ?   Text("To change or delete a game from the table, hold your finger on the name of the game and drag it to the appropriate buttons.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ) : Text("Чтобы изменить или удалить игру из таблицы, удерживайте палец на названии игры и перетащите её к соответствующим кнопкам.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Image(image: AssetImage("assets/changeDeleteEvent.png"),
                width: 210,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Home.lang == "en" ?    Text("Swipe the event or mission card to the left to delete or change them.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ) : Text("Проведите пальцем по карточке ивента или миссии влево, чтобы удалить или изменить их.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ) ,
              ),
            SizedBox(height: 5,),
            Image(image: AssetImage("assets/swipeEventMission.png"),
              width: 190,
            ),
              SizedBox(height: 70,),


            ],
          ),
        ),
      ),
    );

    else
      return Container(
        margin: EdgeInsets.all(20),
        child: Container(
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        children: [
        SizedBox(height: 25,),
        Center(
        child: Image.asset(
        'assets/appBarImage.png',
        width: 80,
        ), // Bu kısımda resmi gösterin
        ),



          for(int j = 0 ; j < gameData.length ; j++)
              Accordion(
                  headerBorderColor: Colors.grey[100],
                  headerBorderColorOpened: Colors.grey[100],
                  headerBackgroundColorOpened: Colors.grey[300],
                  headerBackgroundColor: Colors.grey[200],
                  contentBackgroundColor: Colors.transparent,
                  contentBorderColor: Colors.transparent,
                  contentBorderWidth: 3,
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  children: [
                    AccordionSection(
                      isOpen: true, // Initially open
                      contentVerticalPadding: 20,
                      header: Text(gameData[j]["name"], style: TextStyle(
                        color: Colors.orange
                      ),
                      ),
                      content: Column(
                        children: [

                          for(int k = 0 ; k<eventData.length ; k++)
                            if(eventData[k]["gameName"] == gameData[j]["name"])
                              SwipeActionCell(
                                key: ObjectKey('swipeKey1'),
                                backgroundColor: Colors.transparent,
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                    onTap: (completionHandler) {
                                      // Handle swipe action (e.g., perform action on swipe right)
                                      completionHandler(true);
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
                                      MissionAdd.id = missionData[j]["id"];
                                    },
                                    color: Colors.blue,
                                    icon: Icon(Icons.edit_note_sharp,
                                      color: Colors.white,),
                                    title: "edit",
                                  ),
                                ],

                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey3,
                                    borderRadius: BorderRadius.circular(10), // Adjust the value for the desired roundness
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 70,
                                        padding: EdgeInsets.all(8),
                                        color: Color(0xffFFCB1A),
                                        child: Column(
                                            children: [
                                              Text(eventData[k]["dateTime"].toString().split(" ")[1],
                                                style: (TextStyle(
                                                    fontSize: 12
                                                )),
                                              ),
                                              SizedBox(height: 3,),
                                              Text(eventData[k]["dateTime"].toString().split(" ")[0].substring(0, 3),
                                                style: (TextStyle(
                                                    fontSize: 11
                                                )),
                                              )
                                            ]
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      Container(
                                      width: 190,
                                      child: Column(
                                          children: [
                                            Text(eventData[k]["name"],
                                              style: (TextStyle(
                                                  fontSize: 12
                                              )),
                                            ),
                                            SizedBox(height: 3,),
                                            Text(eventData[k]["description"],
                                              style: (TextStyle(
                                                  fontSize: 11
                                              )),
                                            )
                                          ]
                                      ),
                                    ),

                                      SizedBox(width: 10,),

                                      Container(
                                        width: 35,
                                        child: Column(
                                            children: [
                                              getHours(eventData[k]["dateTime"].toString())
                                            ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                               SizedBox(height: 4,),

                          for(int k = 0 ; k<missionData.length ; k++)
                            if(missionData[k]["gameName"] == gameData[j]["name"])
                               Container(
                                 padding: EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                   color: CupertinoColors.systemGrey3,
                                   borderRadius: BorderRadius.circular(10), // Adjust the value for the desired roundness
                                 ),
                                 child: Row(
                                   children: [
                                     Image(image: FileImage(File(missionData[k]["imgPath"].replaceFirst("File: '", "").replaceFirst("'", ""))),
                                       width: MediaQuery.of(context).size.width * 0.35,
                                       height: 70,
                                     ),
                                     Container(
                                       width: 140,
                                       child: Text(missionData[k]["mission"]),
                                     )

                                   ],
                                 ),
                               ),

                          SizedBox(height: 4,),

                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFCB1A),
                                      borderRadius: BorderRadius.circular(7), // Adjust the radius to make it more rounded
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {
                                            AddMission.gameName = gameData[j]["name"];
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMission()));
                                          },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15, // Set the size of the icon here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Home.lang == "en" ?  Text("Add\nmission", textAlign: TextAlign.center) : Text("Создать\nмиссию", textAlign: TextAlign.center)
                                ],
                              ),

                              SizedBox(width: 25,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFCB1A),
                                      borderRadius: BorderRadius.circular(7), // Adjust the radius to make it more rounded
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {
                                          AddEventDetail.gameName = gameData[j]["name"];
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventDetail()));
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15, // Set the size of the icon here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Home.lang == "en" ?   Text("Add\nevent", textAlign: TextAlign.center) : Text("Создать\nивент", textAlign: TextAlign.center)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ]
        ),
      ),
    ),
      );
  }
}
