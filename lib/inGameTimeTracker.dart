import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/widgets.dart';

import 'db_helper.dart';


class InGameTimeTracker extends StatelessWidget {
  InGameTimeTracker({super.key});


  static var timeId;

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
var time;
var remain;
class _TimeTrackerBodyState extends State<TimeTrackerBody> {
  late CountDownController _controller = CountDownController();



   var db =  UserDatabaseProvider();
   Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere


    timeData = await db.getTimeData(db.database);
    time   = timeData[InGameTimeTracker.timeId - 1]["time"];
    remain = timeData[InGameTimeTracker.timeId - 1]["remain"];
    setState(() {

    });
    print(timeData);
    if (timeData.isNotEmpty) {
      // Process retrieved data
      for (var character in timeData) {
        // Print other character details as needed
      }
    } else {
      print('No character data found.');
    }


    print(timeData);
  }



  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });
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
    ),
    ),

      Text(InGameTimeTracker.timeId.toString()),

      Center(
        child: CircularCountDownTimer(
          duration: time ,
          initialDuration: remain,
          controller: CountDownController(),
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 1.5,
          ringColor: Colors.grey[300]!,
          ringGradient: null,
          fillColor: Color(0xffFFCB1A)!,
          fillGradient: null,
          backgroundGradient: null,
          strokeWidth: 20.0,
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
            print('Countdown Changed');
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            db.updateTimeDataById(db.database,InGameTimeTracker.timeId , duration.inSeconds);
            print(duration.inMinutes * 60 + duration.inSeconds);
            return Function.apply(defaultFormatterFunction, [duration]);
          },
        ),
      ),

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
      )


      
  ]
    ),
    ),
    );
  }
}
