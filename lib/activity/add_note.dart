import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crud_with_simple_note/models/note_model.dart';

class NoteAdd extends StatefulWidget {
  String appBarTitle;


  NoteAdd(this.appBarTitle, {super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  //var appBarTitle = widget.appBarTitle;
  static var PriorityItem = ['Law', 'Height'];
  var selectedPriority = 'Law';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.appBarTitle),
        leading: IconButton(onPressed: (){moveToLastActivity();}, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: WillPopScope(
        onWillPop: () async{
          moveToLastActivity();
          return true;
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              ListTile(
                title: DropdownButton(
                  value: selectedPriority,
                  items: PriorityItem.map((String dropDownMenuItem) {
                    return DropdownMenuItem(
                      value: dropDownMenuItem,
                      child: Text(dropDownMenuItem),
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    selectedPriority = newvalue!;
                    print(selectedPriority);
                  },
                ),
              ),
              TextField(
                controller: titleController,
                style: TextField.materialMisspelledTextStyle,
                onChanged: (value) {
                  print('something change in the title text');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: "title",
                    hintStyle: textStyle,
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                style: TextField.materialMisspelledTextStyle,
                onChanged: (value) {
                  if (kDebugMode) {
                    print('something change in the title text');
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: "Description",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      print("Note Saved");
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.purple; // Change color on hover
                          }
                          return Colors.deepPurpleAccent; // Default color
                        },
                      ),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print("Note Delete");
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.purple; // Change color on hover
                              }
                              return Colors.deepPurpleAccent; // Default color
                            },
                          ),
                          foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastActivity() {
    Navigator.pop(context);
  }
}
