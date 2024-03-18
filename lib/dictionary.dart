import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'db_helper.dart';
import 'home.dart';

class Dictionary extends StatelessWidget {
  const Dictionary({Key? key}) : super(key: key);

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
        body: DictionaryBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Color(0xffFFCB1A),
          child: Icon(Icons.keyboard_backspace_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DictionaryBody extends StatefulWidget {
  const DictionaryBody({Key? key}) : super(key: key);

  @override
  State<DictionaryBody> createState() => _DictionaryBodyState();
}

class _DictionaryBodyState extends State<DictionaryBody> {
  var alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  var color = Color(0xffF5F5F7);
  var selectedColor = Color(0xffFFCB1A);

  var selectedChar = "A";

  var data = [];

  var currData = [];

  var firstChar = "A";
  var currChar = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var db = UserDatabaseProvider();
    await db.open();
    data = await db.getDictionaryList();
    setState(() {
    });
  }

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
              ), // Bu kısımda resmi gösterin
            ),
            SizedBox(height: 5,),
            Home.lang == "en" ? Text("Dictionary of gaming slang") : Text("Словарь игрового сленга"),
            SizedBox(height: 5,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int i = 0 ; i<alphabet.length ; i++)
                    if(alphabet[i] == selectedChar)
                        GestureDetector(
                          onTap: (){
                            selectedChar = alphabet[i];
                            setDataList(alphabet[i]);
                            setState(() {

                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: selectedColor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Text( alphabet[i]  ),
                          ),
                        )
                     else
                      GestureDetector(
                        onTap: (){
                          selectedChar = alphabet[i];
                          setDataList(alphabet[i]);
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Text( alphabet[i]),
                        ),
                      )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(25)
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  SizedBox(width:10),
                  Icon(Icons.search,
                    color: Colors.grey,),
                  SizedBox(width:10),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(width:10),
                  Expanded(
                    child: TextField(
                      //! Filtreleme alanlarında kullanılabilir bir özellik.
                      onChanged: (String deger) {
                       setDataList(deger);
                      },
                      onSubmitted: (String deger) {
                        setDataList(deger);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                  child: Column(
                      children: [
              
                        for(int i = 0 ; i<data.length ; i++)
                          getList(i),
              
                      ]
                  ),
                ),
            ),
          ],
        ),
      );
  }

  getList(int i) {
      if(data[i]["description"][0] == firstChar && firstChar != currChar){
        currChar = firstChar;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(firstChar,
              textAlign: TextAlign.start,
            ),
            Container(
              height: 1,
              color: Color(0xffE58A00),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xffF5F5F7),
                  borderRadius: BorderRadius.circular(25)
              ),
              width: MediaQuery.of(context).size.width * 1,
              child: Text(data[i]["description"]),
            ),
          ],
        );
      }else if(data[i]["description"][0] != firstChar){
        firstChar = data[i]["description"][0];
        currChar = firstChar;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(firstChar,
              textAlign: TextAlign.start,
            ),
            Container(
              height: 1,
              color: Color(0xffE58A00),

            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              decoration: BoxDecoration(
                  color: Color(0xffF5F5F7),
                  borderRadius: BorderRadius.circular(25)
              ),
              width: MediaQuery.of(context).size.width * 1,
              child: Text(data[i]["description"]),
            ),
          ],
        );
      }
      else{
        return Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          decoration: BoxDecoration(
              color: Color(0xffF5F5F7),
              borderRadius: BorderRadius.circular(25)
          ),
          width: MediaQuery.of(context).size.width * 1,
          child: Text(data[i]["description"]),
        );
      }

  }



  Future<void> setDataList(String deger) async {

    await getData();

    var newList = [];

    print(deger);

    data.forEach((element) {
      print(element["description"]);
      if (element["description"].toString().toLowerCase().startsWith(deger.toLowerCase())) {
        newList.add(element);
      }
    });

    data  = newList;

    setState(() {

    });
  }
}
