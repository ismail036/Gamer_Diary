import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';


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
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.all(20),
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Center(
                  child: Image.asset(
                  'assets/appBarImage.png',
                  width: 80,
                  ),),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 110,
                        decoration: BoxDecoration(
                            color:Color(0xffF5F5F7),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      GestureDetector(
                        onTap: (){

                        },
                          child: Container(
                                 margin: EdgeInsets.only(top: 10,left: 15),
                                 height: 90,
                                 child: SvgPicture.asset("assets/Group 65.svg")
                          ),
                        ),
                      GestureDetector(
                        onTap: (){
                          print("selected");
                        },
                        child: Container(
                           margin: EdgeInsets.only(top: 95,left: 65),
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/editImage.png"),
                          ),
                      ),
                    ],
                  )

            ]
          ),
       ),
    );
  }
}

