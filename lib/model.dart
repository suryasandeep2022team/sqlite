import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String _dbName = "myDataBase.db";
final String _tableName = "myData";
final String columnId = "id";
final String columnName = "name";
class SqliteModel{
  String name;
  int id;

  SqliteModel( {required this.name ,  required this.id});

  Map<String ,dynamic> toMap(){
    return {
      columnName  : this.name
    };
  }
}

class SqliteHelper{
 static Database? _database;
 Future<Database> get database async {
    return _database ??= await _initializeDatabase();}


  _initializeDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,_dbName);
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }
  Future _onCreate(Database db,int version){
    return db.execute(
        '''
     CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnName TEXT NOT NULL )
     '''
    );
  }
  Future<int> insert(Map<String,dynamic> row) async{
    Database db= await database;
    return db.insert(_tableName, row,conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<SqliteModel>> fetchAll() async{
    Database db= await database;
    final List<Map<String,dynamic>> tasks = await db.query(_tableName);

    return List.generate(tasks.length,(index){
      return SqliteModel(name: tasks[index][columnName], id: tasks[index][columnId]);
    }
    );
  }

 Future<int> update(SqliteModel model) async{
   Database db= await database;
   int id = model.id;
   return await db.update(_tableName, model.toMap(),where: '$columnId=?',whereArgs: [id]);
 }
 Future<int> delete(int id) async{
   Database db= await database;
   return await db.delete(_tableName,where: '$columnId=?',whereArgs: [id]);
 }
}