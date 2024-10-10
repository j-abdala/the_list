import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/data/database.dart';
import 'package:the_list/utilities/dialog_box.dart';
import 'package:the_list/utilities/thelist_tile.dart';
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
    db.loadData();
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // save new category
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(backgroundColor: Theme.of(context).primaryColorDark,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        centerTitle: true,
        title: Text('The List', 
          style: Theme.of(context).textTheme.displaySmall
        ),
        elevation: 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewCategory,
        backgroundColor: Colors.amber[900],
        child: const Icon(Icons.add, color: Colors.white,)),
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