import 'package:flutter/material.dart';
import 'package:gamer_diary/eventSchedule.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import 'db_helper.dart';

class AddEventDetail extends StatelessWidget {
  const AddEventDetail({super.key});

  static var gameName = "";

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
        body: AddEventBody(),
      ),
    );
  }
}

class AddEventBody extends StatefulWidget {
  const AddEventBody({super.key});

  @override
  State<AddEventBody> createState() => _AddEventBodyState();
}

String month = "";
String day = "";
String year = "";
String hour = "";
String minute = "";

String name = "";
String description = "";

class _AddEventBodyState extends State<AddEventBody> {
  List<Widget> monthWidgets = [
    Text("January"),
    Text("February"),
    Text("March"),
    Text("April"),
    Text("May"),
    Text("June"),
    Text("July"),
    Text("August"),
    Text("September"),
    Text("October"),
    Text("November"),
    Text("December"),
  ];

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];



  Future<void> saveEvent() async {
    var db = UserDatabaseProvider();
    var date = month + " " + day + " " + year + " " + hour + " " + minute;
    print(date);
    await db.open();
    await db.addEventData(AddEventDetail.gameName, name, description, date);
  }


  List<Widget> dayWidgets = [

  ];

  List<String> days = [];

  List<Widget> yearWidgets = [

  ];

  List<String> years = [];

  List<Widget> hoursWidgets = [

  ];

  List<String> hours = [];

  List<Widget> minutesWidgets = [

  ];

  List<String> minutes = [];

  void setDays(){
    for(int i = 1;i<32;i++){
      days.add(i.toString());
      dayWidgets.add(
        Text(i.toString())
      );
    }
  }

  void setYears(){
    for(int i = 2025;i>2010;i--){
      years.add(i.toString());
      yearWidgets.add(
          Text(i.toString())
      );
    }
  }

  void setHours(){
    for(int i = 0;i<24;i++){
      hours.add(i.toString());
      hoursWidgets.add(
          Text(i.toString())
      );
    }
  }

  void setMinutes(){
    for(int i = 0;i<60;i++){
      minutes.add(i.toString());
      minutesWidgets.add(
          Text(i.toString())
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    setDays();
    setYears();
    setHours();
    setMinutes();
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 23,),
              Center(
                child: Image.asset(
                  'assets/appBarImage.png',
                  width: 80,
                ),),
              SizedBox(height: 130,),

              Text("Enter the name of the event",
                textAlign: TextAlign.left,
              ),


              TextField(
                maxLines: 2,
                style: TextStyle(color: Color(0xFFE58A00)),
                decoration: InputDecoration(
                  hintText: "Enter the name of the event",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE58A00)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE58A00)),
                  ),
                ),

                  onChanged: (value) {
                    setState(() {
                      name =
                          value; // Update the gameName variable with the entered text
                    });
                  }
              ),

              SizedBox(height: 10,),
              Text("Enter a description of the event",
                textAlign: TextAlign.left,
              ),


              TextField(
                maxLines: 2,
                style: TextStyle(color: Color(0xFFE58A00)),
                decoration: InputDecoration(
                  hintText: "Enter a description of the event ",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE58A00)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE58A00)),
                  ),
                ),


                  onChanged: (value) {
                    setState(() {
                      description =
                          value; // Update the gameName variable with the entered text
                    });
                  }

              ),

              SizedBox(height: 20,),

              Center(
                child: Text("Set date"),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: WheelChooser.custom(
                      onValueChanged: (a) => month = months[a],
                      children: monthWidgets
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 100,
                    child: WheelChooser.custom(
                      onValueChanged: (a) => day = days[a],
                      children: dayWidgets,
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 100,
                    child: WheelChooser.custom(
                      onValueChanged: (a) => year = years[a],
                      children: yearWidgets,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Center(
                child: Text("Set time"),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: WheelChooser.custom(
                      onValueChanged: (a) => hour = hours[a],
                      children: hoursWidgets,
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 100,
                    child: WheelChooser.custom(
                      onValueChanged: (a) => minute = minutes[a],
                      children: minutesWidgets,
                    ),
                  ),
                ],
              ),




              SizedBox(height: 100,),
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
                      saveEvent();
                      EventSchedule.isSet = false;
                      Navigator.of(context).pop();
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

