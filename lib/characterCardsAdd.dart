import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamer_diary/db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';

class CharacterCardsAdd extends StatelessWidget {
  const CharacterCardsAdd({super.key});

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
        body: CharacterCardsAddBody(),
      ),
    );
  }
}

class CharacterCardsAddBody extends StatefulWidget {
  const CharacterCardsAddBody({super.key});

  @override
  State<CharacterCardsAddBody> createState() => _CharacterCardsAddBodyState();
}

class _CharacterCardsAddBodyState extends State<CharacterCardsAddBody> {

  File? _image;
  double _currentSliderValuelevel = 0;
  double _currentSliderValuepower = 0;
  double _currentSliderValueperception = 0;
  double _currentSliderValuedexterity = 0;
  double _currentSliderValueintelligence = 0;

  var db = UserDatabaseProvider();

  var classValue   = "";
  var name         = "";
  var level        = 0;
  var power        = 0;
  var dexerity     = 0;
  var perception   = 0;
  var intelligence = 0;
  var description  = "";


  @override
  Widget build(BuildContext context) {



    db.open();


    final picker = ImagePicker();

    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    var pickedFile;
    Future getImage() async {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          print(_image.toString());
        } else {
          print('No image selected.');
        }
      });

      print(_image);
    }

    getImg() {
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


    String dropdownValue = list.first;


    final List<String> genderItems = [
      'Warrior',
      'Assassin',
      'Thief',
      'Archer',
      'Undead',
      'Wizard'
    ];

    String? selectedValue;

    return Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Center(
                    child: Image.asset(
                    'assets/appBarImage.png',
                    width: 80,
                    ),),
                    SizedBox(height: 20,),
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

                    SizedBox(height: 20,),
                    Text("Choose a character class",
                      textAlign: TextAlign.left,
                    ),


                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                           // Set the border color here
                        ),
                        // Set the text color here
                        hintStyle: TextStyle(fontSize: 14, color: Color(0xffE58A00)),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        "Choose a character class",
                        style: TextStyle(fontSize: 14),
                      ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black // Set the text color here
                          ),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return "Choose a character class";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          classValue = (value).toString();
                        });
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                        classValue = (value).toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xffE58A00),
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),

                    SizedBox(height: 15,),

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
                              name  = value; // Update the variable with entered text
                            });
                          },
                        ),
                    ),

                    SizedBox(height: 15,),

                    Text("Enter the character level",
                      textAlign: TextAlign.left,
                    ),

                    Slider(
                      value: _currentSliderValuelevel,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValuelevel.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValuelevel = value;
                          level = value.toInt();
                        });
                      },
                    ),

                    SizedBox(height: 15,),

                    Text("Enter the character power",
                      textAlign: TextAlign.left,
                    ),

                    Slider(
                      value: _currentSliderValuepower,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValuepower.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValuepower = value;
                          power = value.toInt();
                        });
                      },
                    ),

                    SizedBox(height: 15,),

                    Text("Enter the character dexterity",
                      textAlign: TextAlign.left,
                    ),

                    Slider(
                      value:_currentSliderValuedexterity,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValuedexterity.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValuedexterity = value;
                          dexerity = value.toInt();
                        });
                      },
                    ),


                    SizedBox(height: 15,),

                    Text("Enter the character perception",
                      textAlign: TextAlign.left,
                    ),

                    Slider(
                      value: _currentSliderValueperception,
                      max: 100,
                      divisions: 100,
                      label: _currentSliderValueperception.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValueperception = value;
                          perception = value.toInt();
                        });
                      },
                    ),

                    SizedBox(height: 15,),

                    Text("Enter the character intelligence",
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
                          intelligence = value.toInt();
                        });
                      },
                    ),

                    SizedBox(height: 15,),

                    Text("Write a description for the character",
                      textAlign: TextAlign.left,
                    ),


                    TextField(
                      maxLines: 4,
                      style: TextStyle(color: Color(0xFFE58A00)),
                      decoration: InputDecoration(
                        hintText: "Enter your text",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE58A00)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE58A00)),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          description = value.toString();
                        });
                      },
                    ),

                    SizedBox(height: 15,),


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
                            db.addCharacterData(db.database, _image.toString() , classValue, name, level, power, dexerity, perception, intelligence, description);
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


