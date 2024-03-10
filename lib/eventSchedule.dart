import 'package:flutter/material.dart';
import 'package:gamer_diary/addEvent.dart';

class EventSchedule extends StatelessWidget {
  const EventSchedule({super.key});

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent()));
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

class _EventScheduleBodyState extends State<EventScheduleBody> {
  @override
  Widget build(BuildContext context) {
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
              Text("Character cards"),
              SizedBox(height: 20,),
              Text("It's empty here",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff686868)
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Text("To add a game to the table, click on the plus sign button.",
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
                child: Text('In order to add an "event" or "mission", click on the appropriate buttons.',
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
                child: Text("To change or delete a game from the table, hold your finger on the name of the game and drag it to the appropriate buttons.",
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
                child: Text("Swipe the event or mission card to the left to delete or change them.",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff686868),
                  ),
                ),
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
  }
}
