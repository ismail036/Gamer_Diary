import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'db_helper.dart';
import 'home.dart';

class MissionAdd extends StatelessWidget {
  MissionAdd({super.key});

  static var id = 0;

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

List<Map<String, dynamic>> missionData = [];
class _MissionAddBodyState extends State<MissionAddBody> {
  bool _visibility = false;
  bool isChecked = false;
  double _currentSliderValueintelligence = 0;
  var gameName = "";
  var description = "";
  var purpose = "";

  var  isChe = false;




  Future<void> saveMissinon() async {
    var db = UserDatabaseProvider();
    await db.open();

    if(MissionAdd.id == 0){
      await db.addMissionData(gameName, description, isChecked, _currentSliderValueintelligence.toInt(), 0, purpose, "In progres");
    }else{
      await db.updateMissionData(MissionAdd.id, gameName, description, isChecked, _currentSliderValueintelligence.toInt(), 0, purpose, "In progres");
    }
  }

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


  var db = UserDatabaseProvider();
  Future<void> getData() async {
    await db.open();
    // Assuming 'db' is your database object obtained from somewhere

    setState(() async {
      missionData = await db.getMissionData(db.database);
    });
    if (missionData.isNotEmpty) {
      // Process retrieved data
      for (var character in missionData) {
        // Print other character details as needed
      }
    } else {
      print('No character data found.');
    }
  }

  TextEditingController _controllerName = TextEditingController(text: '');
  TextEditingController _controllerDescription = TextEditingController(text: '');
  TextEditingController _controllerPurpose = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    getData();


    if(MissionAdd.id != 0 && isChe == false){
      print(missionData.length);
      for(int k = 0;k<missionData.length;k++){
        print(missionData[k]["id"]);
        if(missionData[k]["id"] == MissionAdd.id){
            gameName    = missionData[k]["name"];
            description = missionData[k]["description"];
            purpose = missionData[k]["purpose"];
            print(gameName);
            _currentSliderValueintelligence = missionData[k]["number"].toDouble();
            setState(() {
              _controllerName        = TextEditingController(text: gameName);
              _controllerDescription = TextEditingController(text: description);
              _controllerPurpose     = TextEditingController(text: purpose);
            });

            print(gameName);

            if(missionData[k]["numeric"] == 1){
              isChecked = true;
              _visibility = true;
            }
            isChe = true;
        }
      }
    }



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


            Home.lang == "en" ?  Text("Enter the name of the game",
              textAlign: TextAlign.left,
            ) : Text("Название игры",
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
                child:  Home.lang == "en" ? TextField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'game title..',
                  ),
                  onChanged: (value) {
                    setState(() {
                      gameName = value;
                    });

                  },
                ) : TextField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'название игры...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      gameName = value;
                    });

                  },
                )
              ),

            SizedBox(height: 15,),

            Home.lang == "en" ?  Text("Write a description of the mission",
              textAlign: TextAlign.left,
            ) : Text("Напишите описание миссии",
              textAlign: TextAlign.left,
            ),


            Home.lang == "en" ?  TextField(
              controller: _controllerDescription,
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
                onChanged: (value) {
                setState(() {
                  description =
                      value;
                });// Update the gameName variable with the entered text
                }
            ) : TextField(
                controller: _controllerDescription,
                maxLines: 4,
                style: TextStyle(color: Color(0xFFE58A00)),
                decoration: InputDecoration(
                  hintText: "Описание миссии...",
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
                        value;
                  });// Update the gameName variable with the entered text
                }
            ),

            SizedBox(height: 10,),

            Center(
              child:  Home.lang == "en" ?  Text("Numeric ?") : Text("Числовая?"),
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
                      _visibility = isChecked;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 10,),


            Visibility(
              visible: _visibility,
              child: Column(
                children: [

                  Home.lang == "en" ?  Text("Enter a number",
                    textAlign: TextAlign.left,
                  ) : Text("Введите число",
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

                  Home.lang == "en" ?   Text("Enter what is the purpose of the number",
                    textAlign: TextAlign.left,
                  ) : Text("Введите, для чего предназначен это число",
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
                    child: Home.lang == "en" ?  TextField(
                      controller: _controllerPurpose,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'purpose of the number...',
                      ),
                        onChanged: (value) {
                          setState(() {
                            purpose =
                                value; // Update the gameName variable with the entered text
                          });
                        }
                    ) : TextField(
                        controller: _controllerPurpose,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'назначение числа...',
                        ),
                        onChanged: (value) {
                          setState(() {
                            purpose =
                                value; // Update the gameName variable with the entered text
                          });
                        }
                    ),
                  ),
                ],
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
                    saveMissinon();
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




        ]
        ),
      )
    );
  }
}
