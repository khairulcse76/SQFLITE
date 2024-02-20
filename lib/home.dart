

import 'package:crud_with_simple_note/activity/add_note.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var count  = 50;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),


      body: getNoteListView(),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteAdd(),));
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  ListView getNoteListView(){

    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;

    return  ListView.builder(
      itemCount: count,
        shrinkWrap: true,
        itemBuilder:(BuildContext context, int index){
        return Card(
          color: Colors.white70,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_double_arrow_right),
            ),
            title: Text("My Title", style: titleStyle,),
            subtitle: Text("my Subtitle", style: titleStyle,),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever)),
            onTap: (){
              debugPrint("Pressed on tap");
            },
          ),
        );
        } );
  }
}
