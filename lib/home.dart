import 'dart:io';
import 'package:crud_with_simple_note/services/database_helper.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crud_with_simple_note/models/note_model.dart';
import 'package:crud_with_simple_note/activity/add_note.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseHelper instance = DatabaseHelper();
  late List<NoteModel> noteList = [];
  var itemCount  = 0;

@override
  void initState() {
    super.initState();
    //insertData();
    updateListView();
    getAllnotes();
  }
  void insertData(){
  instance.insertNote(NoteModel("This is Title", DateTime.now().toString(),   1, "_description"));
  }
  Future getAllnotes() async{

  }
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.title),
      ),


      body: getNoteListView(),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          goToAddNoteActivity("Add New Note");
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  ListView getNoteListView(){

    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;

    return  ListView.builder(
      itemCount: noteList.length,
        shrinkWrap: true,
        itemBuilder:(BuildContext context, int index){
        return Card(
          color: Colors.white70,
          elevation: 2.0,
          child: ListTile(
            leading:  CircleAvatar(
              backgroundColor:getPriorityColor(noteList[index].priority),
              child: Icon(Icons.keyboard_double_arrow_right),
            ),
            title: Text("My Title", style: titleStyle,),
            subtitle: Text("my Subtitle", style: titleStyle,),
            trailing: IconButton(onPressed: (){
              _delete(context, noteList[index]);
            }, icon: const Icon(Icons.delete_forever, color: Colors.deepPurpleAccent,size: 30,)),
            onTap: (){
              goToAddNoteActivity("Update Note");
            },
          ),
        );
        } );
  }
  // Return the priority colors
  Color getPriorityColor(int priority){
    switch(priority){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.deepPurpleAccent;
        break;
      default:
        return Colors.deepPurpleAccent;
    }
  }
  IconData? getPriorityIcon(int priority){
    switch (priority){
      case 1:
        return Icons.play_arrow;
        break;
      case 2:
        return Icons.keyboard_double_arrow_right;
        break;
      default:
        return Icons.keyboard_double_arrow_right;
    }
  }
  void _delete(BuildContext context, NoteModel note) async{
    var result = await instance.deleteNote(note.id!);
    if(result !=null && result !=0){
      _showSnackBar(context, "Note was Delete");
    }
  }

  void updateListView() async {

    /*final Future<Database> dbFuture = instance.initializeDatabase();
    dbFuture.then((database) {
      Future<List<NoteModel>> noteListFuture = instance.getNoteList();
      noteListFuture.then((updatedNoteList) {
        setState(() {
          // Use a different name for the local variable
          noteList = updatedNoteList;
          // Assuming 'index' is defined somewhere in your code
          print(noteList[index].title);
        });
      });
    });*/
  }
  void _showSnackBar(BuildContext context, String msg){
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void goToAddNoteActivity(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteAdd(title),));
  }
}
