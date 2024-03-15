

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseProvider {
  var _userDatabaseName = "gameDb";
  var _userTableName = "gameDictionaryTb";
  var _charTableName = "characterTb";
  var _timeTableName = "timeTb";
  var _missionTable = "missionTb";
  var _gameTb = "gameTb";
  var _eventTb = "eventTb";
  var _eventMission = "eventMissionTb";

  var _version = 1;
  late Database database;


  Future<void> open() async {
    try {
      database = await openDatabase(
        _userDatabaseName,
        version: _version,
        onCreate: (db, version) async {
          await db.execute('''
        CREATE TABLE $_userTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT
        );
        ''');
          await db.execute('''
        CREATE TABLE $_charTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          imgPath TEXT,
          class TEXT,
          name TEXT,
          level INTEGER,
          power INTEGER,
          dexerity INTEGER,
          perception INTEGER,
          intelligence INTEGER,
          description TEXT
        );
        ''');
          await db.execute('''
        CREATE TABLE $_timeTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          time INTEGER,
          remain INTEGER
        );
        ''');
            await db.execute('''
          CREATE TABLE $_missionTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            numeric BOOLEAN,
            number INTEGER,
            purpose TEXT
          );
          ''');
          await db.execute('''
          CREATE TABLE $_gameTb (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          );
          ''');
          await db.execute('''
          CREATE TABLE $_eventTb (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gameName TEXT,
            name TEXT,
            description TEXT, 
            dateTime TEXT
          );
          ''');
          await db.execute('''
          CREATE TABLE $_eventMission (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gameName TEXT,
            imgPath TEXT,
            mission TEXT
          );
          ''');
          await db.execute(
              '''
              INSERT INTO $_userTableName (description) 
VALUES 
("Ability – a skill, spell, or ability of a character."),
("Aggro - to cause aggression of a mob, to provoke it to attack itself. Tanks usually attack, preventing the mob from attacking other team members."),
("Agro / aggro / agra — aggressive mobs attacking the character first. In some RPGs, agras can be so aggressive that they can attack each other."),
("Addon - is an addition to the game, for example, adding new levels, weapons, gear, etc.."),
("Adde - 1) mobs that suddenly attack the player when he is busy fighting with other mobs. 2) mobs that make up the boss's 'retinue'."),
("Ai - is an artificial intelligence."),
("Account / acc - is a set of personal data of a person gender, age, first name, last name, password, etc., often called an account, with which he logs into a website or a game."),
("Alt - from alternative character is an additional character in relation to the main one chara. Violas are usually started for the sake of curiosity - when there is a desire to play with another class. Sometimes the new class turns out to be more interesting than the old one, and then the first Persian becomes the viola."),
("Gold - is the game currency in many MMORPGs, purchased for real money or mined in the game."),
("Go - move."),
("Goldseller - is a player who illegally trades game currency for real money.");
    ''');
        },
      );
    } catch (e) {
      print("Error opening database: $e");
    }
  }

  Future<void> addGameData(String name) async {
    // Ensure that the database is already opened
    if (database == null) {
      throw Exception("Database is not open!");
    }

    try {
      // Insert data into the database
      await database.insert(
        _gameTb,
        {
          'name': name,
        },
      );
      print('Data added successfully');
    } catch (e) {
      print('Failed to add data: $e');
      // Handle error
    }
  }

  Future<void> addEventData(String gameName ,  String name,String description , String date) async {
    // Ensure that the database is already opened
    if (database == null) {
      throw Exception("Database is not open!");
    }

    try {
      // Insert data into the database
      await database.insert(
        _eventTb,
        {
          'gameName'  : gameName,
          'name'        : name,
          'description' : description ,
          'dateTime'    : date
        },
      );
      print('Data added successfully');
    } catch (e) {
      print('Failed to add data: $e');
      // Handle error
    }
  }

  Future<void> addEventMissionData(String gameName , String imgPath,String description) async {
    // Ensure that the database is already opened
    if (database == null) {
      throw Exception("Database is not open!");
    }

    try {
      // Insert data into the database
      await database.insert(
        _eventMission,
        {
          'gameName'  : gameName,
          'imgPath'   : imgPath,
          'mission'   : description ,
        },
      );
      print('Data added successfully');
    } catch (e) {
      print('Failed to add data: $e');
      // Handle error
    }
  }

  Future<void> addMissionData(String name, String description, bool numeric ,int number, String purpose) async {
    // Ensure that the database is already opened
    if (database == null) {
      throw Exception("Database is not open!");
    }


    try {
      // Insert data into the database
      await database.insert(
        _missionTable,
        {
          'name': name,
          'description': description,
          'numeric': numeric,
          'number' : number,
          'purpose' : purpose
        },
      );
      print('Data added successfully');
    } catch (e) {
      print('Failed to add data: $e');
      // Handle error
    }
  }

  Future<List<Map<String, dynamic>>> getMissionData(Database db) async {

    List<Map<String, dynamic>> result = await db.query(_missionTable);

    return result;
  }


  Future<void> addTimeData(Database db, String name, int time, int remain) async {
    // Define the table name

    // Prepare the SQL statement
    String sql = '''
    INSERT INTO $_timeTableName (name, time, remain)
    VALUES (?, ?, ?)
  ''';

    // Execute the SQL statement with parameters
    await db.rawInsert(sql, [name, time, remain]);
  }

  Future<List<Map<String, dynamic>>> getTimeData(Database db) async {
    // Define the table name

    // Execute the SQL statement to get data
    List<Map<String, dynamic>> result = await db.query(_timeTableName);

    return result;
  }


  Future<void> addWorkoutData(String type, String name, String imgPath, String main_img_path ,int repetitions, String calories, String description) async {
    // Ensure that the database is already opened
    if (database == null) {
      throw Exception("Database is not open!");
    }

    try {
      // Insert data into the database
      await database.insert(
        _userTableName,
        {
          'type': type,
          'name': name,
          'img_path': imgPath,
          'main_img_path' : main_img_path,
          'repetitions': repetitions,
          'calories': calories,
          'description': description,
        },
      );
      print('Data added successfully');
    } catch (e) {
      print('Failed to add data: $e');
      // Handle error
    }
  }

  Future<void> addCharacterData(Database db,  String imgPath, String classValue, String name, int level, int power, int dexerity, int perception, int intelligence, String description) async {
    try {
      await db.execute('''
      INSERT INTO $_charTableName (imgPath, class, name, level, power, dexerity, perception, intelligence, description)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [imgPath, classValue, name, level, power, dexerity, perception, intelligence, description]);
      print('Data added successfully');
    } catch (e) {
      print('Error adding data: $e');
    }
  }


  Future<void> updateCharacterData(Database db, int id, String imgPath, String classValue, String name, int level, int power, int dexerity, int perception, int intelligence, String description) async {
    try {
      await db.execute('''
      UPDATE $_charTableName 
      SET imgPath = ?, 
          class = ?, 
          name = ?, 
          level = ?, 
          power = ?, 
          dexerity = ?, 
          perception = ?, 
          intelligence = ?, 
          description = ?
      WHERE id = ?
    ''', [imgPath, classValue, name, level, power, dexerity, perception, intelligence, description, id]);
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> deleteCharacter(Database db, int id) async {
    try {
      await db.execute('''
      DELETE FROM $_charTableName 
      WHERE id = ?
    ''', [id]);
      print('Data deleted successfully');
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCharacterData(Database db) async {
    try {
      List<Map<String, dynamic>> dataList = await db.rawQuery('SELECT * FROM $_charTableName');
      return dataList;
    } catch (e) {
      print('Error retrieving data: $e');
      return [];
    }
  }


  Future<void> updateData(int rep, int id) async {
    if (database == null) {
      throw Exception("Database is not open!");
    }

    await database.execute(
        '''
        UPDATE $_userTableName
        SET 'repetitions' = $rep
        WHERE id = $id;
      '''
    );
  }

 /* Future<void> updateWater(int amount, String date) async {
    if (database == null) {
      throw Exception("Database is not open!");
    }


    print(date);


    await database.execute(
        '''
        INSERT INTO $_waterTableName (count, time) VALUES ($amount, '${date.toString()}')
      '''
    );
  } */



  Future<void> updateImage() async {
    if (database == null) {
      throw Exception("Database is not open!");
    }

    await database.execute(
        '''
        UPDATE $_userTableName
        SET 'main_img_path' = 'assets/images/main/oppositeArmMain.png'
        WHERE id = 22;
      '''
    );
  }

  Future<List<Map<String, dynamic>>> getListType(String type) async {
    List<Map<String, dynamic>> userMaps = await database.query(_userTableName);
    List<Map<String, dynamic>> filteredList = [];
    for (var userMap in userMaps) {
      if (userMap['type'] == type) {
        filteredList.add(userMap);
      }
    }
    return filteredList;
  }











  Future<List<Map<String, dynamic>>> getDictionaryList() async {
    List<Map<String, dynamic>> userMaps = await database.query(_userTableName);
    return userMaps;
  }

  /*Future<List<Map<String, dynamic>>> getWaterList() async {
    List<Map<String, dynamic>> userMaps = await database.query(_waterTableName);
    return userMaps;
  }*/





}