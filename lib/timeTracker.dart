import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/widgets.dart';
import 'package:gamer_diary/setGameTime.dart';


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

class _TimeTrackerBodyState extends State<TimeTrackerBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
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

        ],
      ),
    );
  }
}

