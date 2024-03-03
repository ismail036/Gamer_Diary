import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gamer_diary/timeTracker.dart';

import 'characterCards.dart';
import 'dictionary.dart';
import 'listOfMission.dart';
final _key = GlobalKey<ExpandableFabState>();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/background.png'), // Replace 'background_image.jpg' with your image path
          fit: BoxFit.cover, // You can change the BoxFit as per your requirement
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: HomeBody(),
        ),
      );
  }
}


class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var _opacity = 0.0;
  var _settingVisible = false;
  var settingPresed = false;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Stack(
        children : [ Container(
          margin: EdgeInsets.only(top: 38),
          child: SizedBox.expand(
            child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/appBarImage.png',
                      width: 80,
                    ), // Bu kısımda resmi gösterin
                  ),
                  SizedBox(height: 70,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dictionary()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F7),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/enchanted_book.png"),
                            width: MediaQuery.of(context).size.width * 0.35,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Text("Dictionary of gaming slang",textAlign: TextAlign.center),
                          )
                    
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterCard()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F7),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/magical_sword.png"),
                            width: MediaQuery.of(context).size.width * 0.30,),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Text("Character cards",textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTracker()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F7),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/sand-clock-isolated.png"),
                            width: MediaQuery.of(context).size.width * 0.25,),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Text("In-game time tracker",
                              textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfMission()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(6),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F7),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/list_mission.png"),
                            width: MediaQuery.of(context).size.width * 0.35,),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Text("List of missions",textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(6),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F7),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage("assets/event_schedule.png"),
                          width: MediaQuery.of(context).size.width * 0.35,),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Text("Event schedule",textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),

          Visibility(
            visible: _settingVisible,
            child: Opacity(
              opacity: _opacity,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                color: Colors.grey,
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[

                Visibility(
                  visible: _settingVisible,
                    child: Stack(
                      alignment: Alignment.topCenter,
                  children: [
                    Image.asset("assets/Rectangle 9.png"),
                    Column(
                      children: [
                        SizedBox(height: 15,),
                        Text("Sound"),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed: () { 
                              print("sound presed");
                            },
                            child: Image.asset("assets/Sound.png")
                        ),
                        SizedBox(height: 25,),
                        Text("Language"),
                        SizedBox(height: 10,),
                        Image.asset("assets/en.png"),
                        SizedBox(height: 30,),
                        Image.asset("assets/ru.png"),
                      ],
                    )
                  ],
                )),

                IconButton(
                icon: Image.asset(
                  'assets/setting.png',
                  width: 50,
                  height: 50,
                ), onPressed: () {
                  setState(() {
                    if(settingPresed == false){
                      _opacity = 0.3;
                      settingPresed = true;
                      _settingVisible = true;
                    }else{
                      settingPresed = false;
                      _opacity = 0;
                      _settingVisible = false;
                    }
                  });
              },
              ),
                SizedBox(height: 10,)
              ]
            )
          )
       ]
      ),
    );
  }
}
