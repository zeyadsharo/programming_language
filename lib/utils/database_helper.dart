import 'package:project/model/lang.dart';
import 'package:project/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
class DatabaseHelper{
  static Database _db;
  final String langtable = 'langtable';
  final String columnId = 'id';
  final String columnlang = 'lang';
  final String columndescription = 'description';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await intDB();
    return _db;
  }


  intDB() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path , 'mydb.db');
    var myOwnDB = await openDatabase(path,version: 1,
        onCreate: _onCreate);
    return myOwnDB;
  }
  
  void _onCreate(Database db , int newVersion) async{
    var sql = "CREATE TABLE $langtable ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $columnlang TEXT, $columndescription TEXT )";
    await db.execute(sql);
  }

Future<int> saveUser( User user) async{
    var dbClient = await  db;
    int result = await dbClient.insert("$langtable", user.toMap());
    return result;
}
Future<int> saveLang( Lang lang) async{
    var dbClient = await  db;
    int result = await dbClient.insert("$langtable", lang.toMap());
    return result;
}

  Future<List> getAllUsers() async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $langtable";
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getCount() async{
    var dbClient = await  db;
    var sql = "SELECT COUNT(*) FROM $langtable";

    return  Sqflite.firstIntValue(await dbClient.rawQuery(sql)) ;
  }

  Future<User> getUser(int id) async{
    var dbClient = await  db;
    var sql = "SELECT * FROM $langtable WHERE $columnId = $id";
    var result = await dbClient.rawQuery(sql);
    if(result.length == 0) return null;
    return  new User.fromMap(result.first) ;
  }


  Future<int> deleteUser(int id) async{
    var dbClient = await  db;
    return  await dbClient.delete(
        langtable , where: "$columnId = ?" , whereArgs: [id]
    );
  }

  Future<int> updateUser(User user) async{
    var dbClient = await  db;
    return  await dbClient.update(
   langtable ,user.toMap(), where: "$columnId = ?" , whereArgs: [user.id]
    );
  }
  Future<void> close() async{
    var dbClient = await  db;
        return  await dbClient.close();
  }


}