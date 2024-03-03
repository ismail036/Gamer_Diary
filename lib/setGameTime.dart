import 'package:flutter/material.dart';

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

class SetGameTimeBody extends StatelessWidget {
  const SetGameTimeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
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
            ),
          ),
        ],
      ),
    );
  }
}
