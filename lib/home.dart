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
  var itemCount  = 50;
  late List<NoteModel> noteList;

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
      itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder:(BuildContext context, int index){
        return Card(
          color: Colors.white70,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor:Colors.deepPurpleAccent,
              child: Icon(Icons.keyboard_double_arrow_right),
            ),
            title: Text("My Title", style: titleStyle,),
            subtitle: Text("my Subtitle", style: titleStyle,),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever, color: Colors.deepPurpleAccent,size: 30,)),
            onTap: (){
              goToAddNoteActivity("Update Note");
            },
          ),
        );
        } );
  }
  
  void goToAddNoteActivity(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteAdd(title),));
  }
}
