import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
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



  @override
  Widget build(BuildContext context) {


    final picker = ImagePicker();

    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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


    String dropdownValue = list.first;

    final List<String> genderItems = [
      'Male',
      'Female',
    ];

    String? selectedValue;

    return Container(
          margin: EdgeInsets.all(20),
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
                        borderSide: BorderSide( // Set the border color here
                          color: Color(0xffE58A00), // Set your desired color here
                          width: 2.0, // Set the border width if needed
                        ),
                      ),
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
                      //Do something when selected item is changed.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
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




            ]
          ),
    );


  }

}


