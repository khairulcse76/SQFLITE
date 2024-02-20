import 'package:flutter/material.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  var appBarTitle = "My Title";
  static var PriorityItem = ['Law', 'Height'];
  var selectedPriority = 'Law';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                value: selectedPriority,
                items: PriorityItem.map((String dropDownMenuItem){
                return DropdownMenuItem(
                  value: dropDownMenuItem,
                  child: Text(dropDownMenuItem),
                );
                }).toList(),
                onChanged: (newvalue){
                  selectedPriority=newvalue!;
                  print(selectedPriority);
                },
              ),
            ),
            TextField(
              controller: titleController,
              style: TextField.materialMisspelledTextStyle,
              onChanged: (value){
                print('something change in the title text');
              },
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: "title",
                labelStyle: TextStyle(color: Colors.black,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )

              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: descriptionController,
              style: TextField.materialMisspelledTextStyle,
              onChanged: (value){
                print('something change in the title text');
              },
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: "Description",
                  labelStyle: TextStyle(color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )

              ),
            )
          ],
        ),
      ),
    );
  }
}
