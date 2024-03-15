import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/widgets.dart';
import 'package:gamer_diary/setGameTime.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'db_helper.dart';


class TimeTracker extends StatelessWidget {
  const TimeTracker({super.key});

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
        body: TimeTrackerBody(),
      ),
    );
  }
}

class TimeTrackerBody extends StatefulWidget {
  const TimeTrackerBody({super.key});

  @override
  State<TimeTrackerBody> createState() => _TimeTrackerBodyState();
}

List<Map<String, dynamic>> timeData = [];
class _TimeTrackerBodyState extends State<TimeTrackerBody> {

  var db = UserDatabaseProvider();
  Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere

    timeData = await db.getTimeData(db.database);
    setState(() {

    });
    if (timeData.isNotEmpty) {
      // Process retrieved data
      for (var character in timeData) {
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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Center(
              child: Image.asset(
                'assets/appBarImage.png',
                width: 80,
              ),),
            SizedBox(height: 60,),
            Text("The name of the game",
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
                  hintText: ' game title..',
                ),
              ),
            ),
      
            Center(
              child: CircularCountDownTimer(
                  duration: 0,
                  initialDuration: 0,
                  controller: CountDownController(),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 3,
                  ringColor: Colors.grey[300]!,
                  ringGradient: null,
                  fillColor: Colors.grey[300]!,
                  fillGradient: null,
                  backgroundGradient: null,
                  strokeWidth: 15.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.w300),
                  textFormat: CountdownTextFormat.HH_MM_SS,
                  isReverse: false,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    debugPrint('Countdown Started');
                  },
                  onComplete: () {
              
                  },
                  onChange: (String timeStamp) {
                    print('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                      return Function.apply(defaultFormatterFunction, [duration]);
                  },
                ),
            ),
      
            Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffFFCB1A),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SetGameTime()));
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("Statistics:"),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffFFCB1A),
              ),
              child: Center(child: Text("892 h",textAlign: TextAlign.center,)),
              ),
            Text("Your total time:"),
            SizedBox(height: 25,),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int i = 0 ; i<timeData.length ; i++)
                    Container(
                      width: 110,
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffFFCB1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                          children: [
                            Text(timeData[i]["name"]),
                            Text(getTime(timeData[i])),
                            SizedBox(height: 10,),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 9.0,
                              percent: 20 / timeData[i]["time"],
                              progressColor: Colors.white,
                              center: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Text( ((20 / timeData[i]["time"]) * 100).toString().split(".")[0] + '%')),
                              ),
                            ),
                          ]
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 50,),

            Center(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                backgroundColor: Color(0xffFFCB1A),
                child: Icon(
                  Icons.keyboard_backspace_rounded,
                  color: Colors.white,
                ),
              ),
            ),
      
      
      
      
      
          ],
        ),
    ),
    );
  }


  String getTime(Map<String, dynamic> timeData) {
    String timeR = minutesToTime(timeData["time"]);
    String time = minutesToTime(timeData["remain"]);
    return time + " / " + timeR;
  }


  String minutesToTime(int minutes) {
    int hours = minutes ~/ 60; // Get the whole number of hours
    int remainingMinutes = minutes % 60; // Get the remaining minutes

    // Format the result as a string
    String timeString = '$hours:${remainingMinutes.toString().padLeft(2, '0')}';

    return timeString;
  }
}

