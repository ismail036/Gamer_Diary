import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'db_helper.dart';

class AddMission extends StatelessWidget {
  const AddMission({super.key});

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
        body: AddMissionBody(),
      ),
    );
  }
}

class AddMissionBody extends StatefulWidget {
  const AddMissionBody({super.key});

  @override
  State<AddMissionBody> createState() => _AddMissionBodyState();
}

class _AddMissionBodyState extends State<AddMissionBody> {


  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    print(_image);
  }

  var description = "";


  Future<void> saveMissinon() async {
    var db = UserDatabaseProvider();
    await db.open();
    await db.addEventMissionData(AddMission.gameName, _image.toString(),description);
    Navigator.of(context).pop();
  }


  getImg() {
    print(_image);
    if(_image != null )
      return Container(
        margin: EdgeInsets.only(top: 10,left: 10),
        height: 110,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Kenar yarıçapını istediğiniz değere ayarlayın
          image: DecorationImage(
            image: FileImage(_image!),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      );

    return Container(
      margin: EdgeInsets.only(top: 10,left: 10),
      height: 110,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Kenar yarıçapını istediğiniz değere ayarlayın
        image: DecorationImage(
          image: AssetImage("assets/clickToAddPhoto.png"),
          fit: BoxFit.cover,
        ),
      ),
    );


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
    SizedBox(height: 23,),
    Center(
    child: Image.asset(
    'assets/appBarImage.png',
    width: 80,
    ),),
    SizedBox(height: 130,),

      SizedBox(height: 20,),
      Center(child: Text("Add a character")),
      SizedBox(height: 5,),
      Center(
        child: Stack(
          children: [
            Container(
              width: 180,
              height: 130,
              decoration: BoxDecoration(
                  color:Color(0xffF5F5F7),
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            GestureDetector(
                onTap: () async {
                  getImage();
                  setState(() {
                  });
                },
                child:  getImg()
            ),
            GestureDetector(
              onTap: (){
                print("selected");
              },
              child: Container(
                margin: EdgeInsets.only(top: 110,left: 75),
                width: 30,
                height: 30,
                child: Image.asset("assets/editImage.png"),
              ),
            ),
          ],
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
          hintText: "Description of the mission...",
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

      SizedBox(height: 240,),
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

      SizedBox(height: 15,),
    ]
    ),
    ),
    );
  }
}
