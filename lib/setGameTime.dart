import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import 'db_helper.dart';

class SetGameTime extends StatelessWidget {
  const SetGameTime({super.key});

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
        body: SetGameTimeBody(),
      ),
    );
  }
}

class SetGameTimeBody extends StatefulWidget {
  const SetGameTimeBody({super.key});

  @override
  State<SetGameTimeBody> createState() => _SetGameTimeBodyState();
}

class _SetGameTimeBodyState extends State<SetGameTimeBody> {
  var currValueHour   = 1;
  var currValueMinutes = 0;
  var gameName = "";

  List<Widget> hoursWidgets = [

  ];

  List<Widget> minutesWidgets = [

  ];

  void setHours(){
    for(int i = 1;i<25;i++){
      hoursWidgets.add(
          Text(i.toString())
      );
    }
  }

  void setMinutes(){
    for(int i = 0;i<60;i++){
      minutesWidgets.add(
          Text(i.toString())
      );
    }
  }

  Future<void> saveTime() async {
    var db = UserDatabaseProvider();
    await db.open();
    await db.addTimeData(db.database,gameName , currValueHour * 60 + currValueMinutes, 0);
  }

  @override
  Widget build(BuildContext context) {
    setHours();
    setMinutes();
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
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
            SizedBox(height: MediaQuery.of(context).size.height/2-150,),

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
                      gameName = value; // Update the gameName variable with the entered text
                    });
                  },
                )
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffFFCB1A), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: WheelChooser.custom(
                    onValueChanged: (a) => setState(() {
                      currValueHour = a;
                    }),
                    children: hoursWidgets,
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffFFCB1A), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: WheelChooser.custom(
                    onValueChanged: (a) => setState(() {
                      currValueMinutes = a;
                    }),
                    children: minutesWidgets,
                  ),
                ),
              ],
            ),



            SizedBox(height: 220,),

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
                    saveTime();
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


          ],
        ),
      ),
    );
  }
}

