import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelist_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');

  TheListDatabase db = TheListDatabase();

  @override
  void initState() {
    // if this is the first time opening app, then create default data
    if (_myBox.get('ITEMLIST') == null) {
      db.createInitialData();
    } else {
      // else load data from local database
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.itemsList[index][1] = !db.itemsList[index][1];
    });
    db.updateDatabase();
  }

  // save the new item 
  void saveNewTask() {
    setState(() {
      db.itemsList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create a new item for the list
  void createNewItem() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),);
      }
    );
  }

  // TODO: change this method so that items archieve can be viewable again
  void archieveItem(int index) {
    setState(() {
      db.itemsList.removeAt(index);
    });
    db.updateDatabase();
  }

  // TODO: have a nested list, like a list category then you can see the 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('To Do', 
          style: Theme.of(context).textTheme.displaySmall
        ),
        elevation: 0
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewItem,
        backgroundColor: Colors.amber[900],
        child: const Icon(Icons.add, color: Colors.white,)),
      body: ListView.builder(
        itemCount: db.itemsList.length,
        itemBuilder: (context, index) {
          return TheListTile(
            itemName: db.itemsList[index][0],
            itemCompleted: db.itemsList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            archieveFunction: (context) => archieveItem(index),
          );
        })
    );
  }
}