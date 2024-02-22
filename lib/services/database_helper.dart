import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crud_with_simple_note/models/note_model.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance(); //singleton database Helper
  static Database? _database;

   var noteTable='note_table';
   var colID='id';
   var colTitle='title';
   var colDescription='description';
   var colPriority='priority';
   var colDate='date';

  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
  _databaseHelper ??= DatabaseHelper._createInstance();
  return _databaseHelper;
}
Future<Database?> get database async{
    _database ??= await initializeDatabase();
    return _database;
}
Future<Database> initializeDatabase() async{
    //Get the directory path for both Android and iOS to store database.
Directory directory = await getApplicationDocumentsDirectory();
String path = directory.path+'notes.db';

// Open/create the database at a given path
var notesDatabase = await openDatabase(path, version:1, onCreate:_createDb);
return notesDatabase;
}

  void _createDb(Database db, int newVersion) async {
    var IDType = "INTEGER";
    var TextType = "TEXT";

    await db.execute(
      'CREATE TABLE $noteTable ('
          '$colID $IDType PRIMARY KEY AUTOINCREMENT, '
          '$colTitle $TextType, '
          '$colDescription $TextType, '
          '$colPriority $TextType, '
          '$colDate $TextType)',
    );
  }



//FAtch Operation: Get all note objects from database
Future<List> getNoteMapList() async{
    Database? db = await database;
    //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(noteTable, orderBy: '$colPriority ASC');
    return result.map((map) => NoteModel.formMapObject(map)).toList();
}

//Insert Operation: Insert a Note object to database
  Future<int> insertNote(NoteModel note) async{
    Database? db = await database;
    var result = await db!.insert(noteTable,note.toMap() );
    return result;
  }
// Update Operation: Update a NOte object and save it to database
  Future<int> updateNote(NoteModel note) async{
    Database? db = await database;
    var result = await db!.update(noteTable,note.toMap(), where: '$colID = ?', whereArgs: [note.id] );
    return result;
  }
// Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async{
    Database? db = await database;
    var result = await db!.delete(noteTable, where: '$colID = ?', whereArgs: [id] );
    return result;
  }
//Get number of NOte objects in database
  Future<int?> getCount() async{
    Database? db = await database;
    List<Map<String, dynamic>> x = await db!.rawQuery('SELECT COUNT (*) from $noteTable');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

Future dbClose()async{
    Database? db = await database;
    db!.close();
}


//Get the "MAP LIST" LIST<MAP> and Convert it to Note List
  Future<List<NoteModel>> getNoteList() async{
    var noteMapLIst = await getNoteMapList();
    int count = noteMapLIst.length;
    List<NoteModel> noteList = [];

    for(int i=0; i<count; i++){
      noteList.add(NoteModel.formMapObject(noteMapLIst[i]));
    }
    return noteList;
  }

}//Database Helper Close()