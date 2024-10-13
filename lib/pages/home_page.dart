import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelistcategory_tile.dart';

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
    if (db.itemsList.isNotEmpty){
      db.loadData();
    }
    
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // save new category
  // TODO: add a way to check if there is nothing in the text box
  void saveNewCategory() {
    setState(() {
      db.categoryList.add(_controller.text);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new category
  void createNewCategory() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewCategory,
          onCancel: () => Navigator.of(context).pop(),
        );
      });
  }

  void deleteCategory(int index) {
    setState(() {
      db.categoryList.removeAt(index);
    });
    db.updateDatabase();
  }

  // TODO: add icons to the categories
  
  // List of icons to add
  // House
  // Car
  // Task / Assignment
  //

  // TODO: add a way to delete items that are in a deleted category

  // TODO: add a way to archieve items and/or categories
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text('The List', 
            style: Theme.of(context).textTheme.displaySmall
          ),
        elevation: 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewCategory,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add)),
      body: db.categoryList.isEmpty ? Center(child: Text('Create a new category')) : ListView.builder(
        itemCount: db.categoryList.length,
        itemBuilder: (context, index) {
          return TheListCategoryTile(
            categoryName: db.categoryList[index], 
            deleteFunction: (context) => deleteCategory(index));
        })
    );
  }
}