import 'package:flutter/material.dart';
import 'package:gamer_diary/addEventDetail.dart';
import 'package:gamer_diary/addMission.dart';

import 'addGame.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

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
          ],
        ),
      ),
    );
  }
}
  

class AddEventBody extends StatefulWidget {
  const AddEventBody({super.key});

  @override
  State<AddEventBody> createState() => _AddEventBodyState();
}

class _AddEventBodyState extends State<AddEventBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: Image.asset(
              'assets/appBarImage.png',
              width: 80,
            ),
          ),
          SizedBox(height: 290,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddGame()));
          }, child: Text("Add Game",style: TextStyle(
              color: Color(0xffFFCB1A),
              fontSize: 30
          ))),
          SizedBox(height: 15,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventDetail()));

          }, child: Text("Add Event",style: TextStyle(
              color: Color(0xffFFCB1A),
              fontSize: 30
          ))),
          SizedBox(height: 15,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMission()));
          }, child: Text("Add Mission",style: TextStyle(
              color: Color(0xffFFCB1A),
              fontSize: 30
          )))
        ],
      ),
    );
  }
}
