import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissionAdd extends StatelessWidget {
  const MissionAdd({super.key});

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
        body: MissionAddBody(),
        ),
    );
  }
}


class MissionAddBody extends StatefulWidget {
  const MissionAddBody({super.key});

  @override
  State<MissionAddBody> createState() => _MissionAddBodyState();
}

class _MissionAddBodyState extends State<MissionAddBody> {

  bool isChecked = false;
  double _currentSliderValueintelligence = 0;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xffF5F5F7);
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
          SizedBox(height: 21,),
        Center(
          child: Image.asset(
            'assets/appBarImage.png',
            width: 80,
          ), // Bu kısımda resmi gösterin
        ),


            SizedBox(height: 150,),


            Text("Enter the name of the game",
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
                  hintText: 'game title..',
                ),
              ),
            ),

            SizedBox(height: 15,),

            Text("Write a description of the mission",
              textAlign: TextAlign.left,
            ),


            TextField(
              maxLines: 4,
              style: TextStyle(color: Color(0xFFE58A00)),
              decoration: InputDecoration(
                hintText: "Description of the mission..",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE58A00)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE58A00)),
                ),
              ),
            ),

            SizedBox(height: 10,),

            Center(
              child: Text("Numeric ?"),
            ),
            Center(

              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  checkColor: Color(0xffE58A00),
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,

                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 10,),

            Text("Enter a number",
              textAlign: TextAlign.left,
            ),

            Slider(
              value: _currentSliderValueintelligence,
              max: 100,
              divisions: 100,
              label: _currentSliderValueintelligence.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValueintelligence = value;
                });
              },
            ),

            SizedBox(height: 10,),

            Text("Enter what is the purpose of the number",
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
                  hintText: 'purpose of the number...',
                ),
              ),
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
                  },
                  backgroundColor: Color(0xff1A91FF), // Change color as needed
                  child: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ],
            ),




        ]
        ),
      )
    );
  }
}
